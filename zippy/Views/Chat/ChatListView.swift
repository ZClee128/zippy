//
//  ChatListView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var viewModel: ChatViewModel // Injected
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.lightOceanGradient
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.conversations) { conversation in
                            NavigationLink(destination: ConversationView(conversation: conversation)) {
                                ConversationRowView(conversation: conversation)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 70)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Messages"), displayMode: .inline)
        }
    }
}

struct ConversationRowView: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            if let other = conversation.getOtherParticipant(currentUserId: "current") {
                AvatarView(imageName: other.avatar, size: 56)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(other.username)
                            .font(AppTheme.headline)
                            .foregroundColor(AppTheme.primaryText)
                        
                        Spacer()
                        
                        Text(conversation.timeAgo)
                            .font(AppTheme.caption)
                            .foregroundColor(AppTheme.secondaryText)
                    }
                    
                    HStack {
                        Text(conversation.lastMessage)
                            .font(AppTheme.callout)
                            .foregroundColor(AppTheme.secondaryText)
                            .lineLimit(1)
                        
                        Spacer()
                        

                    }
                }
            }
        }
        .padding(.horizontal, AppTheme.paddingMedium)
        .padding(.vertical, AppTheme.paddingSmall)
        .background(AppTheme.cardBackground.opacity(0.5)) // Works
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
            .environmentObject(ChatViewModel())
    }
}
