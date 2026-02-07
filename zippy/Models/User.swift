//
//  User.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    var username: String
    var email: String
    var bio: String
    var avatarName: String // Asset name or file path
    var followersCount: Int
    var followingCount: Int
    var isFollowing: Bool // Whether current user follows this user
    var blockedUsers: [String] // List of blocked user IDs
    var coins: Int // User's coin balance
    
    init(
        id: String = UUID().uuidString,
        username: String,
        email: String,
        bio: String = "",
        avatarName: String = "person.circle.fill",
        followersCount: Int = 0,
        followingCount: Int = 0,
        isFollowing: Bool = false,
        blockedUsers: [String] = [],
        coins: Int = 0
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.bio = bio
        self.avatarName = avatarName
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.isFollowing = isFollowing
        self.blockedUsers = blockedUsers
        self.coins = coins
    }
    
    // Helper property for display
    var displayName: String {
        username.isEmpty ? email : username
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}
