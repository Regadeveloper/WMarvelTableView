protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    var total: Int { get set }
    func screenTitle() -> String
    func getHeroes(offset: Int)
}

protocol ListHeroesUI: AnyObject {
    var keyword: String? { get set }
    func update(heroes: [CharacterDataModel])
    func set(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    var total: Int
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes(), total: Int = 21) {
        self.getHeroesUseCase = getHeroesUseCase
        self.total = total
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes(offset: Int) {
        getHeroesUseCase.execute(offset: offset, keyword: ui?.keyword) { characterDataContainer in
            self.total = characterDataContainer.total
            print("Characters \(characterDataContainer.characters)")
            if offset == 0 {
                self.ui?.set(heroes: characterDataContainer.characters)
            } else {
                self.ui?.update(heroes: characterDataContainer.characters)
            }
        }
    }
}

