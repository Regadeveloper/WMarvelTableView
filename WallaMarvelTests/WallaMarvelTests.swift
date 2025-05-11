import XCTest
@testable import WallaMarvel

class WallaMarvelTests: XCTestCase {
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
        func execute(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
             completionBlock(CharacterDataContainer(
                count: 1,
                limit: 1,
                offset: 0,
                characters: [WallaMarvelTests.DEFAULTCHARACTER]
             ))
        }
    }

    class MockListHeroesUI: ListHeroesUI {
        var heroes: [CharacterDataModel] = []

        func update(heroes: [CharacterDataModel]) {
            self.heroes = heroes
        }
    }

}
