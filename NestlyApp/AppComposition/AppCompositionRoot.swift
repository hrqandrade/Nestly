import NestlyDesignSystem
import UIKit

enum AppCompositionRoot {
    static func makeRootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationController(for: HomeViewController(), title: Localizable.Tab.home, symbol: "house"),
            navigationController(for: SearchViewController(), title: Localizable.Tab.search, symbol: "magnifyingglass"),
            navigationController(for: FavoritesViewController(), title: Localizable.Tab.favorites, symbol: "heart")
        ]
        tabBarController.tabBar.tintColor = NestlyColor.brandPrimary
        tabBarController.view.backgroundColor = NestlyColor.background
        return tabBarController
    }

    private static func navigationController(
        for root: UIViewController,
        title: String,
        symbol: String
    ) -> UINavigationController {
        root.title = title
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: symbol),
            selectedImage: UIImage(systemName: "\(symbol).fill")
        )
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
