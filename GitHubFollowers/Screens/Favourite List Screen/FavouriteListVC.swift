import UIKit

class FavouriteListVC: UIViewController {

    var tableView: UITableView!
    var dataSource: FavouriteDataSource!
    var delegate: FavouriteDelegate!
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
            guard let self      = self else { return }
            switch result {
            case .success(let favourites):
                if favourites.isEmpty {
                    let message = "No favourites?\nGo follow a user from follower screen 😀"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.favourites = favourites
                self.setDataSourceAndDelegate(with: favourites)
                DispatchQueue.main.async {
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
        tableView.backgroundColor   = .systemBackground
        tableView.separatorStyle    = .none

        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
    }
    
    private func setDataSourceAndDelegate(with favourites: [Follower]) {
        dataSource             = FavouriteDataSource(favourites: favourites, viewController: self)
        delegate               = FavouriteDelegate(favourites: favourites, navigationController: self.navigationController)
        tableView.dataSource   = dataSource
        tableView.delegate     = delegate
    }
}

