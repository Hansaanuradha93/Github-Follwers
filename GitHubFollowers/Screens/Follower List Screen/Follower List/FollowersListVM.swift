import UIKit

final class FollowersListVM {
    
    // MARK: Properties
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching: Bool = false
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isLoadingFollowers: Bool = false
    var lastScrollPosition: CGFloat = 0
}


// MARK: - Methods
extension FollowersListVM {
    
    func saveFavourite(favourite: Follower, completion: @escaping (Bool, String) -> ()) {
        PersistenceManager.updateWith(favourite: favourite, actionType: .add) { error in
            if let error = error {
                completion(false, error.rawValue)
                return
            }
            completion(true, Strings.youHaveSuccessfullyFavouritedTheUser)
        }
    }
    
    
    func getFollowers(username: String, page: Int, completion: @escaping ([Follower]?, GFError?) -> ()) {
        NetworkManager.shared.getFollwers(for: username, page: page) { result in
            switch result {
            case .success(let followers):
                completion(followers, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    
    func getUserInfo(for username: String, completion: @escaping (User?, GFError?) -> ()) {
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
            completion(user, nil)
            case .failure(let error):
                print("Could not get userinfo: \(error)")
                completion(nil, error)
            }
        }
    }
}
