//
//  MockDataService.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation

class MockDataService {
    static func populateMockData(for dataService: DataService) {
        
        // Create mock users
        let users = createMockUsers()
        dataService.allUsers = users
        dataService.saveUsers()
        
        // Create mock posts
        let posts = createMockPosts(users: users)
        dataService.allPosts = posts
        dataService.savePosts()
        
        // Create mock conversations
        let conversations = createMockConversations(users: users)
        dataService.conversations = conversations
        dataService.saveConversations()
        
        // Create mock messages
        let messages = createMockMessages(users: users, conversations: conversations)
        dataService.messages = messages
        dataService.saveMessages()
    }
    
    private static func createMockUsers() -> [User] {
        return [
            User(
                username: "OceanExplorer",
                email: "ocean@zippy.com",
                bio: "Marine biologist and reef enthusiast 🐠 Sharing my aquarium journey",
                avatarName: "avatar1",
                followersCount: 1250,
                followingCount: 340
            ),
            User(
                username: "BettaLover",
                email: "betta@zippy.com",
                bio: "Betta breeder 🐟 20+ years experience. DM for care tips!",
                avatarName: "avatar2",
                followersCount: 890,
                followingCount: 220
            ),
            User(
                username: "ReefMaster",
                email: "reef@zippy.com",
                bio: "Saltwater reef tanks are my passion 🪸 Building coral ecosystems",
                avatarName: "avatar3",
                followersCount: 2100,
                followingCount: 450
            ),
            User(
                username: "FreshwaterFan",
                email: "freshwater@zippy.com",
                bio: "Community tanks & planted aquascapes 🌱 Nature aquarium style",
                avatarName: "avatar4",
                followersCount: 670,
                followingCount: 180
            ),
            User(
                username: "Aquascaper",
                email: "aquascape@zippy.com",
                bio: "Award-winning aquascaper 🏆 Creating underwater landscapes",
                avatarName: "avatar5",
                followersCount: 3400,
                followingCount: 520
            )
        ]
    }
    
    private static func createMockPosts(users: [User]) -> [Post] {
        var posts: [Post] = []
        let captions = [
            // "My new clownfish pair is settling in beautifully! 🐠 They've already found their anemone home.", // Removed
            "Just finished rescaping my 75-gallon planted tank. The Monte Carlo carpet is coming in nicely! 🌱",
            "Check out this stunning electric blue ram! The colors are absolutely incredible.",
            "Feeding time for my discus family. They're getting so big! 🐟",
            "My reef tank under actinics - the coral fluorescence is mesmerizing 🪸",
            "New betta arrived today! Look at those flowing fins 😍",
            "School of neon tetras looking magical in the planted tank ✨",
            "My shrimp colony is thriving! Baby shrimp everywhere 🦐",
            "Sunset viewing of my reef tank - nature's best therapy 🌅",
            "Close-up of my favorite LPS coral polyps extending"
        ]
        
        let tags = [
            // ["clownfish", "saltwater", "reeftank"], // Removed
            ["plantedtank", "aquascape", "montecarlo"],
            ["electricblue", "ram", "cichlid"],
            ["discus", "tropicalfish", "aquarium"],
            ["coral", "reeftank", "actinic"],
            ["betta", "siamesefightingfish", "bettalove"],
            ["neontetra", "schoolingfish", "planted"],
            ["shrimp", "cherryshrimp", "inverts"],
            ["reeftank", "aquariumhobby", "tropical"],
            ["lps", "coral", "reeflife"]
        ]
        
        // Video Posts
        let videoPosts: [Post] = [
            Post(
                authorId: users[2].id, // ReefMaster
                authorUsername: users[2].username,
                authorAvatar: users[2].avatarName,
                media: [MediaItem(type: .video, fileName: "sea.mp4")],
                caption: "The ocean is full of mystery and beauty. 🌊 #ocean #nature #relax",
                tags: ["ocean", "nature", "relax"],
                likesCount: 892,
                commentsCount: 45,
                timestamp: Date()
            ),
            Post(
                authorId: users[4].id, // Aquascaper
                authorUsername: users[4].username,
                authorAvatar: users[4].avatarName,
                media: [MediaItem(type: .video, fileName: "fish.mp4")], // Assuming fish.mp4 exists
                caption: "Look at this schooling behavior! 🐟 So organizing. #fish #schooling #aquarium",
                tags: ["fish", "schooling", "aquarium"],
                likesCount: 567,
                commentsCount: 23,
                timestamp: Date().addingTimeInterval(-3600)
            )
        ]
        
        posts.append(contentsOf: videoPosts)
        
        for i in 0..<9 {
            let user = users[i % users.count]
            let imageNum = (i % 8) + 1
            
            let post = Post(
                authorId: user.id,
                authorUsername: user.username,
                authorAvatar: user.avatarName,
                media: [MediaItem(type: .image, fileName: "fish\(imageNum)")],
                caption: captions[i],
                tags: tags[i],
                likesCount: Int.random(in: 50...500),
                commentsCount: Int.random(in: 5...50),
                isLiked: false,
                timestamp: Date().addingTimeInterval(-Double(i * 3600 * 24)) // Posts from past days
            )
            posts.append(post)
        }
        
        return posts
    }
    
    private static func createMockConversations(users: [User]) -> [Conversation] {
        guard users.count >= 3 else { return [] }
        
        return [
            Conversation(
                participantIds: ["current", users[0].id],
                participantUsernames: ["You", users[0].username],
                participantAvatars: ["person.circle.fill", users[0].avatarName],
                lastMessage: "Thanks for the water parameter advice!",
                lastMessageTime: Date().addingTimeInterval(-3600),
                unreadCount: 0
            ),
            Conversation(
                participantIds: ["current", users[1].id],
                participantUsernames: ["You", users[1].username],
                participantAvatars: ["person.circle.fill", users[1].avatarName],
                lastMessage: "Your betta is gorgeous! What's your feeding schedule?",
                lastMessageTime: Date().addingTimeInterval(-7200),
                unreadCount: 2
            ),
            Conversation(
                participantIds: ["current", users[2].id],
                participantUsernames: ["You", users[2].username],
                participantAvatars: ["person.circle.fill", users[2].avatarName],
                lastMessage: "Would love to see more of your reef setup!",
                lastMessageTime: Date().addingTimeInterval(-14400),
                unreadCount: 0
            )
        ]
    }
    
    private static func createMockMessages(users: [User], conversations: [Conversation]) -> [String: [Message]] {
        guard conversations.count >= 3, users.count >= 3 else { return [:] }
        
        var messages: [String: [Message]] = [:]
        
        // Conversation 1 messages
        messages[conversations[0].id] = [
            Message(
                senderId: users[0].id,
                receiverId: "current",
                content: "Hey! I saw your tank setup, it looks amazing!",
                timestamp: Date().addingTimeInterval(-7200)
            ),
            Message(
                senderId: "current",
                receiverId: users[0].id,
                content: "Thank you! I've been working on it for months.",
                timestamp: Date().addingTimeInterval(-7000)
            ),
            Message(
                senderId: users[0].id,
                receiverId: "current",
                content: "What are your water parameters? My pH has been unstable.",
                timestamp: Date().addingTimeInterval(-6800)
            ),
            Message(
                senderId: "current",
                receiverId: users[0].id,
                content: "I keep pH at 7.8, temp at 78°F. Try adding some crushed coral!",
                timestamp: Date().addingTimeInterval(-4000)
            ),
            Message(
                senderId: users[0].id,
                receiverId: "current",
                content: "Thanks for the water parameter advice!",
                timestamp: Date().addingTimeInterval(-3600)
            )
        ]
        
        // Conversation 2 messages
        messages[conversations[1].id] = [
            Message(
                senderId: "current",
                receiverId: users[1].id,
                content: "Your betta is gorgeous! What's your feeding schedule?",
                timestamp: Date().addingTimeInterval(-7200)
            ),
            Message(
                senderId: users[1].id,
                receiverId: "current",
                content: "Thank you! I feed twice daily, small portions.",
                timestamp: Date().addingTimeInterval(-7000),
                isRead: false
            ),
            Message(
                senderId: users[1].id,
                receiverId: "current",
                content: "Are you interested in breeding bettas?",
                timestamp: Date().addingTimeInterval(-7000),
                isRead: false
            )
        ]
        
        // Conversation 3 messages
        messages[conversations[2].id] = [
            Message(
                senderId: "current",
                receiverId: users[2].id,
                content: "Would love to see more of your reef setup!",
                timestamp: Date().addingTimeInterval(-14400)
            ),
            Message(
                senderId: users[2].id,
                receiverId: "current",
                content: "I'll post an update this week. Stay tuned!",
                timestamp: Date().addingTimeInterval(-14000)
            )
        ]
        
        return messages
    }
}
