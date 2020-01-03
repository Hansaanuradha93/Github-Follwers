//
//  User.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/3/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var company: String?
    var email: String
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
