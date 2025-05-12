protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = DependencyContainer.shared.apiClient) {
        self.apiClient = apiClient
    }
    
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(offset: offset, completionBlock: completionBlock)
    }

    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void) {
        return apiClient.getHero(name: name, completionBlock: completionBlock)
    }
}
