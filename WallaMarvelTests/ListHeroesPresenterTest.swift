import XCTest
@testable import WallaMarvel

class ListHeroesPresenterTest: XCTestCase {
    static let DEFAULTCHARACTER = CharacterDataModel(id: 1, name: "Name", thumbnail: Thumbnail(path: "path", extension: "jpg"))


    func testGetHeroesUseCase() {
        let mockGetHeroesUseCase = MockGetHeroesUseCase()
        let listHeroesUI = MockListHeroesUI()
        let listHeroesPresenter = ListHeroesPresenter(getHeroesUseCase: mockGetHeroesUseCase)
        listHeroesPresenter.ui = listHeroesUI

        listHeroesPresenter.getHeroes(offset: 0)
        XCTAssertEqual(listHeroesUI.heroes.count, 1)
    }

    struct MockGetHeroesUseCase: GetHeroesUseCaseProtocol {
        func execute(offset: Int, keyword: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
             completionBlock(CharacterDataContainer(
                count: 1,
                limit: 1,
                offset: 0,
                total: 1,
                characters: [DEFAULTCHARACTER]
             ))
        }
    }

    class MockListHeroesUI: ListHeroesUI {
        var keyword: String?
        var heroes: [CharacterDataModel] = []

        func update(heroes: [CharacterDataModel]) {
            self.heroes = heroes
        }
        func set(heroes: [WallaMarvel.CharacterDataModel]) {
            self.heroes = heroes
        }
    }

}
