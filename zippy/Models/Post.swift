//
//  Post.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation

enum MediaType: String, Codable {
    case image
    case video
}

struct MediaItem: Identifiable, Codable {
    let id: String
    let type: MediaType
    let fileName: String // Asset name or file path
    
    init(id: String = UUID().uuidString, type: MediaType, fileName: String) {
        self.id = id
        self.type = type
        self.fileName = fileName
    }
}

struct Post: Identifiable, Codable {
    let id: String
    let authorId: String
    var authorUsername: String
    var authorAvatar: String
    var media: [MediaItem]
    var caption: String
    var tags: [String]
    var likesCount: Int
    var commentsCount: Int
    var isLiked: Bool
    let timestamp: Date
    
    init(
        id: String = UUID().uuidString,
        authorId: String,
        authorUsername: String,
        authorAvatar: String,
        media: [MediaItem],
        caption: String,
        tags: [String] = [],
        likesCount: Int = 0,
        commentsCount: Int = 0,
        isLiked: Bool = false,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.authorId = authorId
        self.authorUsername = authorUsername
        self.authorAvatar = authorAvatar
        self.media = media
        self.caption = caption
        self.tags = tags
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.isLiked = isLiked
        self.timestamp = timestamp
    }
    
    // Helper properties
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
    var firstMedia: MediaItem? {
        media.first
    }
}
