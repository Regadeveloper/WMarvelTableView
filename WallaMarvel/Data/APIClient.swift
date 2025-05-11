import Foundation

protocol APIClientProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void)
}

final class APIClient: APIClientProtocol {
    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }

    enum Endpoints {
        static let characters = "https://gateway.marvel.com:443/v1/public/characters"
    }

    init() { }
    
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {

        let authParamters = getAuthParameters()
        let pageParameters: [String: String] = ["offset": "\(offset)",
                                                "limit": "20"]

        let parameters = authParamters.merging(pageParameters) { (_, new) in new }


        var urlComponent = URLComponents(string: Endpoints.characters)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let dataModel = try? JSONDecoder().decode(CharacterDataContainer.self, from: data!) else {
                print("El endpoint no funciona.")
                if let data = self.loadBackupData(named: "PageOneHeroes") {
                    let model = try! JSONDecoder().decode(CharacterDataContainer.self, from: data)
                    completionBlock(model)
                    print(model)
                }
                return
            }
            completionBlock(dataModel)
            print(dataModel)
        }.resume()
    }

    func getHero(name: String, completionBlock: @escaping (CharacterDetailDataContainer) -> Void) {
        let authParamters = getAuthParameters()
        let detailParameters: [String: String] = ["name": name]

        let parameters = authParamters.merging(detailParameters) { (_, new) in new }

        var urlComponent = URLComponents(string: Endpoints.characters)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        let urlRequest = URLRequest(url: urlComponent!.url!)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let dataModel = try? JSONDecoder().decode(CharacterDetailDataContainer.self, from: data!) else {
                print("El endpoint no funciona.")
                if let data = self.loadBackupData(named: "DetailHeroHulk") {
                    let model = try! JSONDecoder().decode(CharacterDetailDataContainer.self, from: data)
                    completionBlock(model)
                    print(model)
                }
                return
            }
            completionBlock(dataModel)
            print(dataModel)
        }.resume()
    }
}

extension APIClient {
    func getAuthParameters() -> [String: String] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        return ["apikey": publicKey,
                "ts": ts,
                "hash": hash]
    }

    func loadBackupData(named filename: String) -> Data?  {
        guard let mockJson = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Problema con el json")
            return nil
        }

        return try? Data(contentsOf: mockJson)
    }
}
