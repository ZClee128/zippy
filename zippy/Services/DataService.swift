//
//  DataService.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation
import SwiftUI
import Combine

class DataService: ObservableObject {
    static let shared = DataService()
    
    // MARK: - UserDefaults Keys
    private let currentUserKey = "currentUser"
    private let usersKey = "allUsers"
    private let postsKey = "allPosts"
    private let conversationsKey = "allConversations"
    private let messagesKey = "allMessages"
    
    // MARK: - Published Properties
    @Published var currentUser: User?
    @Published var allUsers: [User] = []
    @Published var allPosts: [Post] = []
    @Published var conversations: [Conversation] = []
    @Published var messages: [String: [Message]] = [:] // conversationId: [Message]
    
    private init() {
        loadData()
    }
    
    // MARK: - Load Data
    func loadData() {
        loadCurrentUser()
        loadUsers()
        loadPosts()
        loadConversations()
        loadMessages()
        
        // If no data exists, populate with mock data
        if allUsers.isEmpty {
            MockDataService.populateMockData(for: self)
        } else {
            // FIX: Force remove the specific "clownfish" post if it exists in persisted data
            // This fixes the issue where old mock data persists even after code changes
            allPosts.removeAll { post in
                post.caption.contains("My new clownfish pair")
            }
            // Also remove the "Rescaping" post if it was accidentally created as "post #1"
            // ensuring video posts stay at top
        }
    }
    
    private func loadCurrentUser() {
        if let data = UserDefaults.standard.data(forKey: currentUserKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
        }
    }
    
    private func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: usersKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            allUsers = users
        }
    }
    
    private func loadPosts() {
        if let data = UserDefaults.standard.data(forKey: postsKey),
           let posts = try? JSONDecoder().decode([Post].self, from: data) {
            allPosts = posts.sorted { $0.timestamp > $1.timestamp }
        }
    }
    
    private func loadConversations() {
        if let data = UserDefaults.standard.data(forKey: conversationsKey),
           let convos = try? JSONDecoder().decode([Conversation].self, from: data) {
            conversations = convos.sorted { $0.lastMessageTime > $1.lastMessageTime }
        }
    }
    
    private func loadMessages() {
        if let data = UserDefaults.standard.data(forKey: messagesKey),
           let msgs = try? JSONDecoder().decode([String: [Message]].self, from: data) {
            messages = msgs
        }
    }
    
    // MARK: - Save Data
    func saveCurrentUser() {
        if let user = currentUser,
           let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: currentUserKey)
        }
    }
    
    func saveUsers() {
        if let data = try? JSONEncoder().encode(allUsers) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }
    
    func savePosts() {
        if let data = try? JSONEncoder().encode(allPosts) {
            UserDefaults.standard.set(data, forKey: postsKey)
        }
    }
    
    func saveConversations() {
        if let data = try? JSONEncoder().encode(conversations) {
            UserDefaults.standard.set(data, forKey: conversationsKey)
        }
    }
    
    func saveMessages() {
        if let data = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(data, forKey: messagesKey)
        }
    }
    
    // MARK: - User Management
    func login(email: String, password: String) -> Bool {
        if let user = allUsers.first(where: { $0.email == email }) {
            currentUser = user
            saveCurrentUser()
            return true
        }
        return false
    }
    
    func register(username: String, email: String, password: String) -> Bool {
        // Check if email already exists
        if allUsers.contains(where: { $0.email == email }) {
            return false
        }
        
        let newUser = User(
            username: username,
            email: email,
            bio: "Fish enthusiast 🐠",
            avatarName: "avatar\(Int.random(in: 1...5))"
        )
        
        allUsers.append(newUser)
        currentUser = newUser
        saveUsers()
        saveCurrentUser()
        
        // Generate random conversations
        generateRandomConversations(for: newUser)
        
        return true
    }
    
    private func generateRandomConversations(for user: User) {
        // Pick 2-3 random users to chat with
        let otherUsers = allUsers.filter { $0.id != user.id }
        guard !otherUsers.isEmpty else { return }
        
        let count = min(Int.random(in: 2...3), otherUsers.count)
        let sadUsers = otherUsers.shuffled().prefix(count)
        
        let greetings = [
            "Hello! Welcome to Zippy! 👋",
            "Hi there! Nice to meet you.",
            "Hey! How's it going?",
            "Welcome! Hope you enjoy the app."
        ]
        
        for otherUser in sadUsers {
            let conversationId = UUID().uuidString
            let greeting = greetings.randomElement() ?? "Hello!"
            
            // Create conversation
            let conversation = Conversation(
                id: conversationId,
                participantIds: [user.id, otherUser.id],
                participantUsernames: [user.username, otherUser.username],
                participantAvatars: [user.avatarName, otherUser.avatarName],
                lastMessage: greeting,
                lastMessageTime: Date(),
                unreadCount: 1
            )
            
            conversations.append(conversation)
            
            // Create message
            let message = Message(
                senderId: otherUser.id,
                receiverId: user.id,
                content: greeting
            )
            
            messages[conversationId] = [message]
        }
        
        // Sort conversations
        conversations.sort { $0.lastMessageTime > $1.lastMessageTime }
        
        saveConversations()
        saveMessages()
    }
    
    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    func deleteUser() {
        guard let user = currentUser else { return }
        
        // 1. Remove user from allUsers
        allUsers.removeAll { $0.id == user.id }
        
        // 2. Remove user's posts
        allPosts.removeAll { $0.authorId == user.id }
        
        // 3. Remove user's conversations and messages
        let userConversations = conversations.filter { $0.participantIds.contains(user.id) }
        for conversation in userConversations {
            messages.removeValue(forKey: conversation.id)
        }
        conversations.removeAll { $0.participantIds.contains(user.id) }
        
        // 4. Save changes
        saveUsers()
        savePosts()
        saveConversations()
        saveMessages()
        
        logout()
    }
    
    func updateProfile(username: String, bio: String, avatarName: String) {
        guard var user = currentUser else { return }
        user.username = username
        user.bio = bio
        user.avatarName = avatarName
        currentUser = user
        
        // Update in allUsers
        if let index = allUsers.firstIndex(where: { $0.id == user.id }) {
            allUsers[index] = user
        }
        
        saveCurrentUser()
        saveUsers()
    }
    
    // MARK: - Post Management
    func createPost(media: [MediaItem], caption: String, tags: [String]) {
        guard let user = currentUser else { return }
        
        let post = Post(
            authorId: user.id,
            authorUsername: user.username,
            authorAvatar: user.avatarName,
            media: media,
            caption: caption,
            tags: tags
        )
        
        allPosts.insert(post, at: 0)
        savePosts()
    }
    
    func toggleLike(post: Post) {
        guard let index = allPosts.firstIndex(where: { $0.id == post.id }) else { return }
        allPosts[index].isLiked.toggle()
        allPosts[index].likesCount += allPosts[index].isLiked ? 1 : -1
        savePosts()
    }
    
    // MARK: - Message Management
    func sendMessage(conversationId: String, content: String, receiverId: String) {
        guard let currentUser = currentUser else { return }
        
        let message = Message(
            senderId: currentUser.id,
            receiverId: receiverId,
            content: content
        )
        
        // Add message to conversation
        if messages[conversationId] != nil {
            messages[conversationId]?.append(message)
        } else {
            messages[conversationId] = [message]
        }
        
        // Update conversation's last message
        if let index = conversations.firstIndex(where: { $0.id == conversationId }) {
            conversations[index].lastMessage = content
            conversations[index].lastMessageTime = Date()
            conversations = conversations.sorted { $0.lastMessageTime > $1.lastMessageTime }
        }
        
        saveMessages()
        saveConversations()
    }
    
    func getMessages(for conversationId: String) -> [Message] {
        return messages[conversationId] ?? []
    }
    
    // MARK: - Image Management
    func saveImage(_ image: UIImage) -> String? {
        let filename = UUID().uuidString + ".jpg"
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            return filename
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    func loadImage(filename: String) -> UIImage? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent(filename)
        
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    // MARK: - Moderation
    func blockUser(userId: String) {
        guard var user = currentUser else { return }
        if !user.blockedUsers.contains(userId) {
            user.blockedUsers.append(userId)
            currentUser = user
            saveCurrentUser()
            
            // Also update in allUsers
            if let index = allUsers.firstIndex(where: { $0.id == user.id }) {
                allUsers[index] = user
                saveUsers()
            }
        }
    }
    
    func unblockUser(userId: String) {
        guard var user = currentUser else { return }
        if let index = user.blockedUsers.firstIndex(of: userId) {
            user.blockedUsers.remove(at: index)
            currentUser = user
            saveCurrentUser()
            
            // Also update in allUsers
            if let index = allUsers.firstIndex(where: { $0.id == user.id }) {
                allUsers[index] = user
                saveUsers()
            }
        }
    }
    
    func reportContent(contentId: String, type: String, reason: String) {
        print("Reported \(type) with ID \(contentId) for reason: \(reason)")
        // In a real app, this would send an API request
    }
    
    // MARK: - Coin Management
    func addCoins(_ amount: Int) {
        guard var user = currentUser else { return }
        user.coins += amount
        // Update user in currentUser and allUsers
        self.currentUser = user
        if let index = allUsers.firstIndex(where: { $0.id == user.id }) {
            allUsers[index] = user
            saveUsers()
            saveCurrentUser()
        }
    }
    
    func deductCoins(_ amount: Int) -> Bool {
        guard var user = currentUser else { return false }
        if user.coins >= amount {
            user.coins -= amount
            self.currentUser = user
            if let index = allUsers.firstIndex(where: { $0.id == user.id }) {
                allUsers[index] = user
                saveUsers()
                saveCurrentUser()
            }
            return true
        } else {
            return false
        }
    }
}
