//
//  MessageBubbleView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    let isFromCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
            }
            
            VStack(alignment: isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .font(AppTheme.body)
                    .foregroundColor(isFromCurrentUser ? .white : AppTheme.primaryText)
                    .padding(12)
                    .background(isFromCurrentUser ? AppTheme.primaryBlue : AppTheme.secondaryBackground)
                    .cornerRadius(16)
                
                Text(message.formattedTime)
                    .font(AppTheme.caption)
                    .foregroundColor(AppTheme.secondaryText)
            }
            .frame(maxWidth: 250, alignment: isFromCurrentUser ? .trailing : .leading)
            
            if !isFromCurrentUser {
                Spacer()
            }
        }
    }
}
