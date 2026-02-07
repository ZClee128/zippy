//
//  ChatViewModel.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var messages: [Message] = []
    
    private let dataService = DataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        loadConversations()
    }
    
    func addSubscribers() {
        // Subscribe to currentUser changes (login/logout)
        dataService.$currentUser
            .sink { [weak self] _ in
                self?.loadConversations()
            }
            .store(in: &cancellables)
            
        // Subscribe to conversations changes (new messages/chats)
        dataService.$conversations
            .sink { [weak self] _ in
                self?.loadConversations()
            }
            .store(in: &cancellables)
    }
    
    func loadConversations() {
        guard let currentUserId = dataService.currentUser?.id else {
            conversations = []
            return
        }
        
        let blockedUsers = dataService.currentUser?.blockedUsers ?? []
        
        conversations = dataService.conversations.filter { convo in
            // Filter 1: Must involve current user
            guard convo.participantIds.contains(currentUserId) else { return false }
            
            // Filter 2: Check if OTHER participant is blocked
            if let otherId = convo.getOtherParticipantId(currentUserId: currentUserId) {
                return !blockedUsers.contains(otherId)
            }
            return true
        }
    }
    
    func loadMessages(for conversationId: String) {
        messages = dataService.getMessages(for: conversationId)
    }
    
    func sendMessage(conversationId: String, content: String, receiverId: String) {
        dataService.sendMessage(conversationId: conversationId, content: content, receiverId: receiverId)
        loadMessages(for: conversationId)
        loadConversations()
    }
    
    func blockUser(userId: String) {
        dataService.blockUser(userId: userId)
        loadConversations()
    }
    
    func reportUser(userId: String, reason: String) {
        dataService.reportContent(contentId: userId, type: "User", reason: reason)
    }
}
