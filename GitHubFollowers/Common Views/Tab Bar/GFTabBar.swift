import UIKit

class GFTabBar: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavouriteListNC()]
    }

    
    func createSearchNC() -> UINavigationController {
        let searchVC            = SearchVC()
        searchVC.title          = "Search"
        searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavouriteListNC() -> UINavigationController {
        let favouriteListVC             = FavouriteListVC()
        favouriteListVC.title           = "Favourites"
        favouriteListVC.tabBarItem      = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteListVC)
    }
}
