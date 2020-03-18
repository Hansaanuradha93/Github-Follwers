//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/3/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String?
    var avatarUrl: String?
}
