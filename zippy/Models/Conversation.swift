//
//  Conversation.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation

struct Conversation: Identifiable, Codable {
    let id: String
    let participantIds: [String] // For now, just two users
    var participantUsernames: [String]
    var participantAvatars: [String]
    var lastMessage: String
    var lastMessageTime: Date
    var unreadCount: Int
    
    init(
        id: String = UUID().uuidString,
        participantIds: [String],
        participantUsernames: [String],
        participantAvatars: [String],
        lastMessage: String = "",
        lastMessageTime: Date = Date(),
        unreadCount: Int = 0
    ) {
        self.id = id
        self.participantIds = participantIds
        self.participantUsernames = participantUsernames
        self.participantAvatars = participantAvatars
        self.lastMessage = lastMessage
        self.lastMessageTime = lastMessageTime
        self.unreadCount = unreadCount
    }
    
    // Get the other participant's info (assuming 1-on-1 chat)
    func getOtherParticipant(currentUserId: String) -> (username: String, avatar: String)? {
        guard let index = participantIds.firstIndex(where: { $0 != currentUserId }),
              index < participantUsernames.count,
              index < participantAvatars.count else {
            return nil
        }
        return (participantUsernames[index], participantAvatars[index])
    }
    
    func getOtherParticipantId(currentUserId: String) -> String? {
        return participantIds.first(where: { $0 != currentUserId })
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: lastMessageTime, relativeTo: Date())
    }
}
