//
//  Message.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: String
    let senderId: String
    let receiverId: String
    var content: String
    let timestamp: Date
    var isRead: Bool
    
    init(
        id: String = UUID().uuidString,
        senderId: String,
        receiverId: String,
        content: String,
        timestamp: Date = Date(),
        isRead: Bool = false
    ) {
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.content = content
        self.timestamp = timestamp
        self.isRead = isRead
    }
    
    // Helper properties
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}
