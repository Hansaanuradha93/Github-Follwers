//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/6/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL: String = "https://api.github.com/"
    private let perPage = 100
    
    private init() {}
    
    func getFollwers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessages?) -> Void) {
        let endPoint: String = baseURL + "users/\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { // Error validation
                completed(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // Response validation
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else { // Data validation
                completed(nil, .invalidData)
                return
            }
            
            do { // Json Decoding
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follwers = try decoder.decode([Follower].self, from: data)
                
                completed(follwers, nil)
            } catch {
                completed(nil, .invalidData)
            }
            
            
            
        }
        
        task.resume() // Start the task
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
