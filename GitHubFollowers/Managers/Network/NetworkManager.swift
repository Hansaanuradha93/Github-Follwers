import UIKit

class NetworkManager {
    // MARK: - Properties
    static let shared           = NetworkManager()
    private let perPage: Int    = 100
    let cache                   = NSCache<NSString, UIImage>()
    
    
    // MARK: - Initializers
    private init() {}
    
}


// MARK: - Methods
extension NetworkManager {
    
    func getFollwers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint    = GithubEndPoint.followers(username: username, perPage: perPage, page: page)
        let url         = endPoint.url
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { // Error validation
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // Response validation
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { // Data validation
                completed(.failure(.invalidData))
                return
            }
            
            do { // Json Decoding
                let decoder                 = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers               = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endPoint    = GithubEndPoint.user(username: username)
        let url         = endPoint.url
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { // Error validation
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // Response validation
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { // Data validation
                completed(.failure(.invalidData))
                return
            }
            
            do { // Json Decoding
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let user                        = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch let error{
                print("Error: \(error)")
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey            = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard  let url          = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self          = self,
                    error           == nil,
                    let response    = response as? HTTPURLResponse, response.statusCode == 200,
                    let data        = data,
                    let image       = UIImage(data: data) else {
                        completed(nil)
                        return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}












































//
//typealias JSON = [String : Any]
//typealias JSONHandler = (JSON?, HTTPURLResponse?, Error?) -> Void



// Download JSON
//func downloadJSONFromUrl(_ completion : @escaping JSONHandler) {
//
//    let request = URLRequest(url: self.url)
//
//    let dataTask = session.dataTask(with: request) { (data, response, error) in
//
//        // Lets check the http response
//        guard let httpResponse = response as? HTTPURLResponse else { // Missing HTTP Response
//            let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
//            let error = NSError(domain: NetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
//            completion(nil, nil, error as Error)
//            return
//        }
//
//        if data == nil { // Missing Data
//            if let error = error {
//                completion(nil, httpResponse, error)
//            }
//        } else { // Data downloaded successfully
//            switch httpResponse.statusCode {
//            case 200 :
//                // OK Parse JSON to Foundation objects (array, dictionary)
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? JSON
//                    completion(json, httpResponse, nil)
//                } catch {
//                    print("Error when Serializing JSON : \(error.localizedDescription)")
//                    completion(nil, httpResponse, error)
//                }
//
//            default :
//                print("Recieved HTTP Response code : \(httpResponse.statusCode) - was not handled in NetworkProcessor.swift")
//            }
//        }
//    }
//
//    dataTask.resume()
//
//}
