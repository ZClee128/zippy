//
//  CustomButton.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

enum ButtonStyle {
    case primary
    case secondary
    case outline
}

struct CustomButton: View {
    let title: String
    let style: ButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTheme.headline)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(AppTheme.cornerRadiusMedium)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium)
                        .stroke(borderColor, lineWidth: style == .outline ? 2 : 0)
                )
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return AppTheme.primaryBlue
        case .secondary:
            return AppTheme.secondaryAqua
        case .outline:
            return Color.clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .secondary:
            return .white
        case .outline:
            return AppTheme.primaryBlue
        }
    }
    
    private var borderColor: Color {
        style == .outline ? AppTheme.primaryBlue : Color.clear
    }
}
