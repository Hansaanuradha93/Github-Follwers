import UIKit

class FavouriteListVC: DataLoadingVC {

    // MARK: - Properties
    private var tableView: UITableView!
    private var dataSource: FavouriteDataSource!
    var delegate: FavouriteDelegate!
    private var favourites: [Follower] = []

    
    // MARK: - View Controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    
}


// MARK: - Private Methods
extension FavouriteListVC {
    
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
        tableView.backgroundColor   = .systemBackground
        tableView.separatorStyle    = .none
        view.addSubview(tableView)
        tableView.removeExcessCells()
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
    }
    
    
    private func setDataSourceAndDelegate(with favourites: [Follower]) {
        dataSource             = FavouriteDataSource(favourites: favourites, viewController: self)
        delegate               = FavouriteDelegate(favourites: favourites, navigationController: self.navigationController)
        tableView.dataSource   = dataSource
        tableView.delegate     = delegate
    }
}
