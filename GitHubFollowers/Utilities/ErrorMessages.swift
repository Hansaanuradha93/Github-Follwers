//
//  ErrorMessages.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/6/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete the request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "Data recieved from the server is invalid. Please try again."
    
}
