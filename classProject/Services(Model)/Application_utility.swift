import UIKit

class Application_utility {
    static var rootViewController: UIViewController {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let root = windowScene.windows.first?.rootViewController
        else {
            return UIViewController()
        }
        return root
    }
}
