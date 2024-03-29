import UIKit

class FavouriteDataSource: NSObject {

    // MARK: Properties
    private var favourites: [Follower]
    private var viewController: UIViewController
    
    
    // MARK: Initializers
    init(favourites: [Follower], viewController: UIViewController) {
        self.favourites = favourites
        self.viewController = viewController
        super.init()
    }
}

// MARK: - TableView DataSource
extension FavouriteDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.reuseID, for: indexPath) as! FavouriteTableViewCell
        cell.set(favourite: favourites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        removeFavourite(indexPath, tableView)
    }
}


// MARK: - Private Methods
extension FavouriteDataSource {
    
    func removeFavourite(_ indexPath: IndexPath, _ tableView: UITableView) {
        PersistenceManager.updateWith(favourite: favourites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.viewController.presentGFAlertOnMainTread(title: Strings.unableToRemove, message: error.rawValue, buttonTitle: Strings.ok)
        }
    }
}
