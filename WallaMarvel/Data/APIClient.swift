import Foundation

protocol APIClientProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
}

final class APIClient: APIClientProtocol {
    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }
    
    init() { }
    
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let authParamters: [String: String] = ["apikey": publicKey,
                                               "ts": ts,
                                               "hash": hash]
        let pageParameters: [String: String] = ["offset": "\(offset)",
                                                "limit": "20"]

        let parameters = authParamters.merging(pageParameters) { (_, new) in new }


        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let dataModel = try? JSONDecoder().decode(CharacterDataContainer.self, from: data!) else {
                print("El endpoint no va")
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

    func loadBackupData(named filename: String) -> Data?  {
        guard let mockJson = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Problema con el json")
            return nil
        }

        return try? Data(contentsOf: mockJson)
    }
}
