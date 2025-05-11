protocol GetHeroUseCaseProtocol {
    func execute(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void)
}

struct GetHero: GetHeroUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol

    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }

    func execute(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void) {
        repository.getHero(name: name, completionBlock: completionBlock)
    }
}
