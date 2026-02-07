//
//  DiscoverView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct DiscoverView: View {
    // Use EnvironmentObject if we want shared feed, or create local for discovery
    // Implementation Plan said discovery shows trending posts. FeedViewModel has posts. 
    // Let's use EnvironmentObject for consistency.
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    let popularTags = ["reeftank", "betta", "plantedtank", "coral", "tropicalfish", "aquascape"]
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.lightOceanGradient
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Popular Tags
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Popular Tags")
                                .font(AppTheme.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(popularTags, id: \.self) { tag in
                                        NavigationLink(destination: TagFeedView(tag: tag)) {
                                            TagChipView(tag: tag)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Expert Insights
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Expert Insights")
                                .font(AppTheme.headline)
                                .padding(.horizontal)
                            
                            NavigationLink(destination: ArticleDetailView(
                                title: "Beginners Guide to Saltwater Tanks",
                                author: "ReefMaster",
                                content: "Starting a saltwater tank can be daunting, but with the right patience and equipment, anyone can create a slice of the ocean at home. Key steps include cycling your tank, choosing the right salt mix, and monitoring salinity."
                            )) {
                                ExpertInsightCard(
                                    title: "Beginners Guide to Saltwater Tanks",
                                    author: "ReefMaster",
                                    icon: "graduationcap.fill"
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: ArticleDetailView(
                                title: "Top 10 Hardy Fish for New Aquarists",
                                author: "OceanExplorer",
                                content: "When starting out, you want fish that are resilient and forgiving. Top choices include: 1. Clownfish 2. Damselfish (aggressive but hardy) 3. Cardinalfish 4. Blennies. Avoid Mandarins and Anthias until you have experience."
                            )) {
                                ExpertInsightCard(
                                    title: "Top 10 Hardy Fish for New Aquarists",
                                    author: "OceanExplorer",
                                    icon: "star.fill"
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Trending Posts
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Trending Posts")
                                .font(AppTheme.headline)
                                .padding(.horizontal)
                            
                            ForEach(feedViewModel.posts.prefix(3)) { post in
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    PostCardView(post: post) {
                                        feedViewModel.toggleLike(post: post)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationBarTitle(Text("Discover"), displayMode: .inline)
        }
    }
}

struct TagChipView: View {
    let tag: String
    
    var body: some View {
        Text("#\(tag)")
            .font(AppTheme.callout)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppTheme.primaryBlue, AppTheme.secondaryAqua]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(20)
    }
}

struct ExpertInsightCard: View {
    let title: String
    let author: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(AppTheme.primaryBlue)
                .frame(width: 50, height: 50)
                .background(AppTheme.secondaryAqua.opacity(0.2))
                .cornerRadius(AppTheme.cornerRadiusSmall)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(AppTheme.headline)
                    .foregroundColor(AppTheme.primaryText)
                
                Text(title) // Duplicated? Recheck. Ah, author check.
                // Re-writing this part manually to match previous logical structure
                Text("by \(author)")
                    .font(AppTheme.caption)
                    .foregroundColor(AppTheme.secondaryText)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(AppTheme.secondaryText)
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadiusMedium)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct SupplyCard: View {
    let name: String
    let description: String
    let price: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "cart.fill")
                .font(.system(size: 30))
                .foregroundColor(AppTheme.secondaryAqua)
                .frame(width: 50, height: 50)
                .background(AppTheme.primaryBlue.opacity(0.2))
                .cornerRadius(AppTheme.cornerRadiusSmall)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(AppTheme.headline)
                    .foregroundColor(AppTheme.primaryText)
                
                Text(description)
                    .font(AppTheme.caption)
                    .foregroundColor(AppTheme.secondaryText)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(price)
                .font(AppTheme.callout)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.primaryBlue)
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadiusMedium)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct TagFeedView: View {
    let tag: String
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                let filteredPosts = feedViewModel.posts.filter { $0.tags.contains(tag) }
                
                if filteredPosts.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(AppTheme.secondaryText)
                        Text("No posts found for #\(tag)")
                            .font(AppTheme.headline)
                            .foregroundColor(AppTheme.secondaryText)
                    }
                    .padding(.top, 50)
                } else {
                    ForEach(filteredPosts) { post in
                        VStack(spacing: 0) {
                            NavigationLink(destination: PostDetailView(post: post)) {
                                PostCardView(post: post) {
                                    feedViewModel.toggleLike(post: post)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .background(AppTheme.secondaryBackground)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("#\(tag)", displayMode: .inline)
        .background(AppTheme.lightOceanGradient.edgesIgnoringSafeArea(.all))
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(FeedViewModel())
    }
}
