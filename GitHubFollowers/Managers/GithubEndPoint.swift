//
//  GithubEndPoint.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/13/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import Foundation

enum GithubEndPoint {
//    https://api.github.com/users/SAllen0400/followers?per_page=100&page=1
    
    // Cases
    case users(username: String, perPage: Int, page: Int)
    
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
        case .users(let username, _, _): return "/users/\(username)/followers"
        }
    }
    
    // Parameters
    private var parameters: [String : Any] {
        switch self {
        case .users( _,let perPage, let page):
            let parameters: [String : Any] = [
                "per_page": perPage,
                "page": page
            ]
            return parameters
        }
    }
        
    // Query Components
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        for(key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
    
    var url: URL {
//        var components = URLComponents(string: baseURL)!
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryComponents
        return components.url!
    }
    
}




