import UIKit

class FollowersListVM {
    
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
