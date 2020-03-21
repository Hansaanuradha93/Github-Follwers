import UIKit

class FavouriteListVC: UIViewController {

    var tableView: UITableView!
    var dataSource: FavouriteDataSource!
    var favourites: [Follower] = []

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    private func configureViewController() {
        view.backgroundColor                = .systemBackground
        title                               = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favourites):
                if favourites.isEmpty {
                    let message = "No favourites?\nGo follow a user from follower screen 😀"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.favourites                 = favourites
                self.dataSource                 = FavouriteDataSource(favourites: favourites, viewController: self)
                DispatchQueue.main.async {
                    self.tableView.dataSource   = self.dataSource
                    self.view.bringSubviewToFront(self.tableView)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureTableView() {
        tableView                   = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.delegate          = self
        tableView.backgroundColor   = .systemBackground
        tableView.separatorStyle    = .none
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
    }
}


extension FavouriteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favourite   = favourites[indexPath.row]
        let destVC      = FollowersListVC()
        destVC.username = favourite.login
        destVC.title    = favourite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
}
