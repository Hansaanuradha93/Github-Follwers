import UIKit

class UserInfoVM {
    
    func getUserInfo(username: String, completion: @escaping (User?, GFError?) -> ()) {
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                completion(user, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}
