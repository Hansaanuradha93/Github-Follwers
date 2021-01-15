import UIKit

class FavouriteDelegate: NSObject {
    
    // MARK: Properties
    private var favourites: [Follower]
    private var navigationController: UINavigationController?
    
    
    // MARK: Initializers
    init(favourites: [Follower], navigationController: UINavigationController?) {
        self.favourites = favourites
        self.navigationController = navigationController
        super.init()
    }
}


// MARK: - TableView Delegate
extension FavouriteDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favourite = favourites[indexPath.row]
        let destVC = FollowersListVC(username: favourite.login ?? "")
        navigationController?.pushViewController(destVC, animated: true)
    }
}
