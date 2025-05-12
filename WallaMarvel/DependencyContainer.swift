class DependencyContainer {
    static let shared = DependencyContainer()
    var apiClient: APIClientProtocol = APIClient()
}
