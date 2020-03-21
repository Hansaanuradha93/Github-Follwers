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
                self.favourites = favourites
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print("Persistence error: \(error.rawValue)")
            }
        }
    }
    
    
    private func configureTableView() {
        tableView                   = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.backgroundColor   = .systemBackground
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
