protocol DetailHeroPresenterProtocol: AnyObject {
    var ui: DetailHeroUI? { get set }
    func getHero(name: String)
}

protocol DetailHeroUI: AnyObject {
    func update(hero: CharacterDetailDataModel)
}

final class DetailHeroPresenter: DetailHeroPresenterProtocol {
    var ui: DetailHeroUI?
    private let getHeroUseCase: GetHeroUseCaseProtocol

    init(getHeroUseCase: GetHeroUseCaseProtocol = GetHero()) {
        self.getHeroUseCase = getHeroUseCase
    }

    // MARK: UseCases

    func getHero(name: String) {
        getHeroUseCase.execute(name: name) { characterDetailDataContainer in
            print("Character \(characterDetailDataContainer.character)")
            self.ui?.update(hero: characterDetailDataContainer.character)
        }
    }
}
