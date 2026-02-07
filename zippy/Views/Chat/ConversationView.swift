//
//  ConversationView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct ConversationView: View {
    let conversation: Conversation
    @EnvironmentObject var viewModel: ChatViewModel // Injected
    @State private var messageText = ""
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Messages
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageBubbleView(
                                message: message,
                                isFromCurrentUser: message.senderId == "current"
                            )
                        }
                    }
                    .padding()
                    .padding()
                }
                .background(AppTheme.lightOceanGradient)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    showMenu = false
                }
                
                // Message input
                HStack(spacing: 12) {
                    TextField("Message...", text: $messageText)
                        .padding(10)
                        .background(AppTheme.secondaryBackground)
                        .cornerRadius(20)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(messageText.isEmpty ? Color.gray : AppTheme.primaryBlue)
                            .clipShape(Circle())
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
                .background(AppTheme.cardBackground)
            }
            .navigationBarTitle(Text(conversation.getOtherParticipant(currentUserId: "current")?.username ?? "Chat"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                withAnimation {
                    showMenu.toggle()
                }
            }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.primaryBlue)
                    .padding(8)
            })
            
            // Custom Menu Overlay
            if showMenu {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }
                
                VStack(spacing: 0) {
                    Button(action: {
                        reportUser()
                        withAnimation { showMenu = false }
                    }) {
                        Text("Report User")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    
                    Divider()
                    
                    Button(action: {
                        blockUser()
                        withAnimation { showMenu = false }
                    }) {
                        Text("Block User")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    
                    Divider()
                    
                    Button(action: {
                        withAnimation { showMenu = false }
                    }) {
                        Text("Cancel")
                            .foregroundColor(AppTheme.primaryText)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 40)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
        .onAppear {
            viewModel.loadMessages(for: conversation.id)
        }
    }
    
    private func reportUser() {
        if let userId = conversation.getOtherParticipantId(currentUserId: "current") {
            viewModel.reportUser(userId: userId, reason: "User reported from chat")
        }
    }
    
    private func blockUser() {
        if let userId = conversation.getOtherParticipantId(currentUserId: "current") {
            viewModel.blockUser(userId: userId)
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty,
              let receiverId = conversation.participantIds.first(where: { $0 != "current" }) else {
            return
        }
        
        viewModel.sendMessage(
            conversationId: conversation.id,
            content: messageText,
            receiverId: receiverId
        )
        messageText = ""
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
