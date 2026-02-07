//
//  CustomTextField.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct CustomTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(AppTheme.subheadline)
                .foregroundColor(AppTheme.secondaryText)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle()
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle()
            }
        }
    }
}

// Custom text field style
extension View {
    func textFieldStyle() -> some View {
        self
            .font(AppTheme.body)
            .padding()
            .background(AppTheme.secondaryBackground)
            .cornerRadius(AppTheme.cornerRadiusSmall)
            .autocapitalization(.none)
    }
}
