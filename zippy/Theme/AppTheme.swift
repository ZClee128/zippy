//
//  AppTheme.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct AppTheme {
    // MARK: - Colors
    
    // Primary ocean-themed colors
    static let primaryBlue = Color(red: 0.0, green: 0.48, blue: 0.8) // Ocean blue
    static let secondaryAqua = Color(red: 0.0, green: 0.75, blue: 0.75) // Aqua
    static let accentCoral = Color(red: 1.0, green: 0.45, blue: 0.37) // Coral for accents
    
    // Gradient backgrounds
    static let oceanGradient = LinearGradient(
        colors: [primaryBlue, secondaryAqua],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let lightOceanGradient = LinearGradient(
        colors: [Color(red: 0.85, green: 0.95, blue: 1.0), Color(red: 0.9, green: 1.0, blue: 1.0)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // Surface colors
    static let cardBackground = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
    
    // Text colors
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary
    
    // MARK: - Typography
    
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let title = Font.system(size: 28, weight: .bold)
    static let headline = Font.system(size: 17, weight: .semibold)
    static let body = Font.system(size: 17, weight: .regular)
    static let callout = Font.system(size: 16, weight: .regular)
    static let subheadline = Font.system(size: 15, weight: .regular)
    static let footnote = Font.system(size: 13, weight: .regular)
    static let caption = Font.system(size: 12, weight: .regular)
    
    // MARK: - Spacing
    
    static let paddingSmall: CGFloat = 8
    static let paddingMedium: CGFloat = 16
    static let paddingLarge: CGFloat = 24
    static let paddingXLarge: CGFloat = 32
    
    // MARK: - Corner Radius
    
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
    static let cornerRadiusXLarge: CGFloat = 20
    
    // MARK: - Shadows
    
    static func cardShadow() -> some View {
        EmptyView()
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
