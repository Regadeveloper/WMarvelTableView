protocol MarvelRepositoryProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void)
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        dataSource.getHeroes(offset: offset, completionBlock: completionBlock)
    }

    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void) {
        dataSource.getHero(name: name, completionBlock: completionBlock)
    }
}
