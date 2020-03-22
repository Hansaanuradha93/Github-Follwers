import Foundation

enum GithubEndPoint {
    
    // Cases
    case followers(username: String, perPage: Int, page: Int)
    case user(username: String)
    
    
    // Scheme
    private var scheme: String {
        return "https"
    }
    
    
    // Host
    private var host: String {
        return "api.github.com"
    }
    
    
    // Path
    private var path: String {
        switch self {
        case .followers(let username, _, _): return "/users/\(username)/followers"
        case .user(let username): return "/users/\(username)"
        }
    }
    
    
    // Parameters
    private var parameters: [String : Any] {
        switch self {
        case .followers( _,let perPage, let page):
            let parameters: [String : Any] = [
                "per_page": perPage,
                "page": page
            ]
            return parameters
        case .user( _): return ["":""]
        }
    }
      
    
    // Query Components
    private var queryComponents: [URLQueryItem] {
        var components      = [URLQueryItem]()
        for(key, value) in parameters {
            let queryItem   = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
    
    
    var url: URL {
        var components          = URLComponents()
        components.scheme       = scheme
        components.host         = host
        components.path         = path
        components.queryItems   = queryComponents
        return components.url!
    }
}




