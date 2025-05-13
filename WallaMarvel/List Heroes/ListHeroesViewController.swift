import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }

    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Introduce el nombre del héroe"
        return searchController
    }()

    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?

    var isLoading: Bool = true
    private var searchWorkItem: DispatchWorkItem?

    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.ui = self
        presenter?.getHeroes(offset: 0)
        setSearchView()
        navigationItem.searchController = searchController
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
}

extension ListHeroesViewController: ListHeroesUI {
    var keyword: String? {
        get {
            listHeroesProvider?.keyword
        }
        set {
            listHeroesProvider?.keyword = newValue
        }
    }

    func update(heroes: [CharacterDataModel]) {
        isLoading = false
        listHeroesProvider?.heroes += heroes
    }

    func set(heroes: [CharacterDataModel]) {
        isLoading = false
        listHeroesProvider?.heroes = heroes
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = DetailHeroPresenter()
        let detailHeroViewController = DetailHeroViewController(name: listHeroesProvider?.heroes[indexPath.row].name ?? "")
        detailHeroViewController.presenter = presenter

        navigationController?.pushViewController(detailHeroViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoading {
            return
        }
        let lastItem = listHeroesProvider?.heroes.count ?? 0
        guard let total = presenter?.total, lastItem < total else { return }
        let lastItemRow = lastItem == 0 ? 1 : lastItem - 1
        if indexPath.row == lastItemRow {
            isLoading = true
            presenter?.getHeroes(offset: lastItem)
        }
    }
}

extension ListHeroesViewController: UISearchResultsUpdating {
    func setSearchView() {
        searchController.searchResultsUpdater = self
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        searchWorkItem?.cancel()
        listHeroesProvider?.keyword = keyword

        let workItem = DispatchWorkItem { [weak self] in
            self?.presenter?.getHeroes(offset: 0)
        }
        searchWorkItem = workItem

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
}

