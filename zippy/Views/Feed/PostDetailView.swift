//
//  PostDetailView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack(spacing: 12) {
                    AvatarView(imageName: post.authorAvatar, size: 50)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(post.authorUsername)
                            .font(.headline)
                            .foregroundColor(AppTheme.primaryText)
                        
                        Text(post.timeAgo)
                            .font(.subheadline)
                            .foregroundColor(AppTheme.secondaryText)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Media
                if let media = post.firstMedia {
                    MediaViewer(mediaItem: media, aspectRatio: .fit)
                        .frame(height: 350)
                        .background(Color.black)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 12) {
                    // Actions (Like only)
                    Button(action: {
                        feedViewModel.toggleLike(post: post)
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: post.isLiked ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(post.isLiked ? AppTheme.accentCoral : AppTheme.primaryText)
                            Text("\(post.likesCount) likes")
                                .font(.headline)
                                .foregroundColor(AppTheme.primaryText)
                        }
                    }
                    
                    // Caption
                    Text(post.caption)
                        .font(.body)
                        .foregroundColor(AppTheme.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // Tags
                    if !post.tags.isEmpty {
                        WrappingHStack(tags: post.tags)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationBarTitle(Text("Post"), displayMode: .inline)
    }
}

// Helper for wrapping tags
struct WrappingHStack: View {
    let tags: [String]
    
    var body: some View {
        // Simple horizontal scroll for tags if wrapping is too complex for iOS 13 without GeometryReader hacks
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(.subheadline)
                        .foregroundColor(AppTheme.primaryBlue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(AppTheme.secondaryBackground)
                        .cornerRadius(15)
                }
            }
        }
    }
}
