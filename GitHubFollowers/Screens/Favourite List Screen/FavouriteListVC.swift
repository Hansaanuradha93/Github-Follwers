import UIKit

class FavouriteListVC: DataLoadingVC {

    // MARK: Properties
    private var tableView: UITableView!
    private var dataSource: FavouriteDataSource!
    private var favourites: [Follower] = []
    var delegate: FavouriteDelegate!

    
    // MARK: View Controller
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
private extension FavouriteListVC {
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favourites):
                self.updateUI(withFavourites: favourites)
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func updateUI(withFavourites favourites: [Follower]) {
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
    }
    
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.removeExcessCells()
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
    }
    
    
    func setDataSourceAndDelegate(with favourites: [Follower]) {
        dataSource = FavouriteDataSource(favourites: favourites, viewController: self)
        delegate = FavouriteDelegate(favourites: favourites, navigationController: self.navigationController)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
}
