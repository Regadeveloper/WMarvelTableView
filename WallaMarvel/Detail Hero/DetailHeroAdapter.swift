import Foundation

final class DetailHeroAdapter: NSObject {
    var hero: CharacterDetailDataModel? {
        didSet {
            updateView()
        }
    }

    var comics: [ComicItem] {
        guard let hero = hero else { return [] }
        return hero.comics.items
    }

    private let view: DetailHeroView

    init(view: DetailHeroView, hero: CharacterDetailDataModel? = nil) {
        self.view = view
        self.hero = hero
    }

    private func updateView() {
        guard let hero = hero else { return }
        DispatchQueue.main.async {
            self.view.configure(model: hero)
        }
    }
}
