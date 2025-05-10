import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?

    var isLoading: Bool = true

    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.getHeroes(offset: 0)
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: [CharacterDataModel]) {
        isLoading = false
        listHeroesProvider?.heroes += heroes
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = ListHeroesPresenter()
        let listHeroesViewController = ListHeroesViewController()
        listHeroesViewController.presenter = presenter
        
        navigationController?.pushViewController(listHeroesViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoading {
            return
        }
        let lastItem = listHeroesProvider?.heroes.count ?? 0
        let lastItemRow = lastItem == 0 ? 1 : lastItem - 1
        if indexPath.row == lastItemRow {
            isLoading = true
            presenter?.getHeroes(offset: lastItem)
        }
    }
}

