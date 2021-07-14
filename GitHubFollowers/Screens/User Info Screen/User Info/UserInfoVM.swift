import UIKit

final class UserInfoVM {
    
    // MARK: Properties
    var username: String!
    
    
    // MARK: Initializers
    init(username: String) {
        self.username = username
    }
}


// MARK: - Methods
extension UserInfoVM {
    
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
