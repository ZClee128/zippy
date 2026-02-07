//
//  AvatarView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct AvatarView: View {
    let imageName: String
    let size: CGFloat
    
    init(imageName: String, size: CGFloat = 40) {
        self.imageName = imageName
        self.size = size
    }
    
    var body: some View {
        Group {
            if imageName.hasPrefix("avatar") {
                // Use bundled avatar images
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if let image = DataService.shared.loadImage(filename: imageName) {
                // Load saved image
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                // Fallback to SF Symbol
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(AppTheme.secondaryAqua)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}
