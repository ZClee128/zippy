//
//  FeedView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                // LazyVStack -> VStack for iOS 13
                VStack(spacing: 16) {
                    ForEach(viewModel.posts) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            PostCardView(post: post) {
                                viewModel.toggleLike(post: post)
                            }
                            .padding(.horizontal, AppTheme.paddingMedium)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.vertical, AppTheme.paddingMedium)
            }
            .edgesIgnoringSafeArea(.bottom) // optional, but good for background
            .navigationBarTitle(Text("Feed"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(FeedViewModel())
    }
}
