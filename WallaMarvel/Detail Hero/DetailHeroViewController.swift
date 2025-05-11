import UIKit

final class DetailHeroViewController: UIViewController {
    var mainView: DetailHeroView { return view as! DetailHeroView  }

    var presenter: DetailHeroPresenterProtocol?
    var detailHeroProvider: DetailHeroAdapter?

    let name: String

    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailHeroView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getHero(name: name)
        detailHeroProvider = DetailHeroAdapter(view: mainView)
        presenter?.ui = self
    }
}

extension DetailHeroViewController: DetailHeroUI {
    func update(hero: CharacterDetailDataModel) {
        detailHeroProvider?.hero = hero
    }
}

