//
//  User.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 25.09.2024.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarURL: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlURL: String
    var following: Int
    var followers: Int
    var createdAt: String
}
