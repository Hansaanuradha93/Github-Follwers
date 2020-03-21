import UIKit

class FavouriteListVC: UIViewController {

    var tableView: UITableView!
    var favourites: [Follower]          = []
    
    
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
                self.favourites = favourites
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
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
    }
}

extension FavouriteListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.reuseID, for: indexPath) as! FavouriteTableViewCell
        cell.set(favourite: favourites[indexPath.row])
        return cell
    }
    
    
    
}

extension FavouriteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
