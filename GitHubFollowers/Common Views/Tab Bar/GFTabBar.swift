import UIKit

class GFTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavouriteListNC()]
    }
}


// MARK: - Private Methods
private extension GFTabBar {
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = Strings.search
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavouriteListNC() -> UINavigationController {
        let favouriteListVC = FavouriteListVC()
        favouriteListVC.title = Strings.favourites
        favouriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteListVC)
    }
}
