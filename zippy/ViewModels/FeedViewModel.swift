//
//  FeedViewModel.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let dataService = DataService.shared
    
    init() {
        loadPosts()
    }
    
    func loadPosts() {
        let blockedUsers = dataService.currentUser?.blockedUsers ?? []
        posts = dataService.allPosts.filter { !blockedUsers.contains($0.authorId) }
    }
    
    func toggleLike(post: Post) {
        dataService.toggleLike(post: post)
        // Optimistic update or reload? Reload might be heavy but safe.
        // For toggle like, usually we just update the specific post in array, but here we reload.
        loadPosts()
    }
    
    func createPost(media: [MediaItem], caption: String, tags: [String]) {
        dataService.createPost(media: media, caption: caption, tags: tags)
        loadPosts()
    }
    
    func blockUser(userId: String) {
        dataService.blockUser(userId: userId)
        loadPosts() // Refresh to remove posts from blocked user
    }
    
    func reportPost(post: Post, reason: String) {
        dataService.reportContent(contentId: post.id, type: "Post", reason: reason)
    }
}
