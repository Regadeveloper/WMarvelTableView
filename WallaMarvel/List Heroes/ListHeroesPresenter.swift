protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes(offset: Int)
}

protocol ListHeroesUI: AnyObject {
    var keyword: String? { get set }
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes(offset: Int) {
        getHeroesUseCase.execute(offset: offset, keyword: ui?.keyword) { characterDataContainer in
            print("Characters \(characterDataContainer.characters)")
            self.ui?.update(heroes: characterDataContainer.characters)
        }
    }
}

