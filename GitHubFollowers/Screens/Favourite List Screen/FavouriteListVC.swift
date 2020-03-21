import UIKit

class FavouriteListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favourites):
                print("Favourites: \(favourites)")
            case .failure(let error):
                print("Persistence error: \(error.rawValue)")
            }
        }
    }
}
