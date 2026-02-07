//
//  PostCardView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct PostCardView: View {
    let post: Post
    let onLikeTapped: () -> Void
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State private var showActionSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User info header
            HStack(spacing: 12) {
                AvatarView(imageName: post.authorAvatar, size: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.authorUsername)
                        .font(AppTheme.headline)
                    
                    Text(post.timeAgo)
                        .font(AppTheme.caption)
                        .foregroundColor(AppTheme.secondaryText)
                }
                
                Spacer()
                
                Button(action: {
                    showActionSheet = true
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(AppTheme.secondaryText)
                        .padding(8)
                }
            }
            .padding(.horizontal, AppTheme.paddingMedium)
            .padding(.top, AppTheme.paddingMedium)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Options"),
                    buttons: [
                        .destructive(Text("Report Post")) {
                            feedViewModel.reportPost(post: post, reason: "User reported")
                        },
                        .destructive(Text("Block User")) {
                            feedViewModel.blockUser(userId: post.authorId)
                        },
                        .cancel()
                    ]
                )
            }
            .padding(.horizontal, AppTheme.paddingMedium)
            .padding(.top, AppTheme.paddingMedium)
            
            // Media
            if let media = post.firstMedia {
                MediaViewer(mediaItem: media, aspectRatio: .fill)
                    .frame(height: 300)
                    .clipped()
            }
            
            // Action buttons
            HStack(spacing: 20) {
                Button(action: onLikeTapped) {
                    HStack(spacing: 6) {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(post.isLiked ? AppTheme.accentCoral : AppTheme.primaryText)
                        Text("\(post.likesCount)")
                            .font(AppTheme.callout)
                            .foregroundColor(AppTheme.primaryText)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, AppTheme.paddingMedium)
            
            // Caption and tags
            VStack(alignment: .leading, spacing: 8) {
                Text(post.caption)
                    .font(AppTheme.body)
                    .lineLimit(3)
                
                if !post.tags.isEmpty {
                    HStack(spacing: 8) {
                        ForEach(post.tags.prefix(3), id: \.self) { tag in
                            Text("#\(tag)")
                                .font(AppTheme.caption)
                                .foregroundColor(AppTheme.primaryBlue)
                        }
                    }
                }
            }
            .padding(.horizontal, AppTheme.paddingMedium)
            .padding(.bottom, AppTheme.paddingMedium)
        }
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadiusMedium)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
