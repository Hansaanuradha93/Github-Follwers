import UIKit

final class UserInfoVM {
    
    var username: String!
    
    init(username: String) {
        self.username = username
    }

    
    func getUserInfo(completion: @escaping (User?, GFError?) -> ()) {
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
