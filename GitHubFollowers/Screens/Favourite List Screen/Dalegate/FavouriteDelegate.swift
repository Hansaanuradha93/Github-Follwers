import UIKit

class FavouriteDelegate: NSObject, UITableViewDelegate {
    
    private var favourites: [Follower]
    private var navigationController: UINavigationController?
    
    init(favourites: [Follower], navigationController: UINavigationController?) {
        self.favourites = favourites
        self.navigationController = navigationController
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favourite   = favourites[indexPath.row]
        let destVC      = FollowersListVC(username: favourite.login ?? "")
        navigationController?.pushViewController(destVC, animated: true)
    }
}
