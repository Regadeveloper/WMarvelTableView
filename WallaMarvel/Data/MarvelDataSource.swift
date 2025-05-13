protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int, keyword: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = DependencyContainer.shared.apiClient) {
        self.apiClient = apiClient
    }
    
    func getHeroes(offset: Int, keyword: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        apiClient.getHeroes(offset: offset, keyword: keyword, completionBlock: completionBlock)
    }

    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void) {
        apiClient.getHero(name: name, completionBlock: completionBlock)
    }
}
