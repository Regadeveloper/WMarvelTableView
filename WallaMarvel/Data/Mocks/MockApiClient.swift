import Foundation

public final class MockAPIClient: APIClientProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        if let data = loadMockData(named: "PageOneHeroes") {
            let model = try! JSONDecoder().decode(CharacterDataContainer.self, from: data)
            completionBlock(model)
        }
    }

    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void) {
        if let data = loadMockData(named: "DetailHeroABomb") {
            let model = try! JSONDecoder().decode(CharacterDetailDataContainer.self, from: data)
            completionBlock(model)
        }
    }

    private func loadMockData(named filename: String) -> Data?  {
        guard let mockJson = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json") else {
            print("Mock JSON not found.")
            return nil
        }
        return try? Data(contentsOf: mockJson)
    }
}
