import UIKit

final class FavouriteListVM {
    
    func getFavourites(completion: @escaping ([Follower]?, GFError?) -> ()) {
        PersistenceManager.retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                completion(favourites, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
