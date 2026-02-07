//
//  ArticleDetailView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct ArticleDetailView: View {
    let title: String
    let author: String
    let content: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(AppTheme.largeTitle)
                    .bold()
                
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(AppTheme.secondaryText)
                    Text("By \(author)")
                        .font(AppTheme.headline)
                        .foregroundColor(AppTheme.secondaryText)
                }
                
                Divider()
                
                Text(content)
                    .font(AppTheme.body)
                    .lineSpacing(6)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Article", displayMode: .inline)
    }
}
