import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var isRunningUITests: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if AppDelegate.isRunningUITests {
            DependencyContainer.shared.apiClient = MockAPIClient()
        } else {
            DependencyContainer.shared.apiClient = APIClient()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

