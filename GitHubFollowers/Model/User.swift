//
//  User.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/3/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    let login: String?
    let avatarUrl: String?
    let name: String?
    let location: String?
    let bio: String?
    let company: String?
    let email: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String?
    let following: Int?
    let followers: Int?
    let createdAt: String?
}
