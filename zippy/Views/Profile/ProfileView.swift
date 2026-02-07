//
//  ProfileView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    // Use EnvironmentObject instead of StateObject. Provided by SceneDelegate -> RootView
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @State private var showingEditProfile = false
    @State private var showingSettings = false
    @State private var showingCoinStore = false
    
    var currentUser: User? {
        authViewModel.currentUser
    }
    
    var userPosts: [Post] {
        guard let userId = currentUser?.id else { return [] }
        return feedViewModel.posts.filter { $0.authorId == userId }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.lightOceanGradient
                    .edgesIgnoringSafeArea(.all) // iOS 13
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile header
                        VStack(spacing: 16) {
                            AvatarView(
                                imageName: currentUser?.avatarName ?? "person.circle.fill",
                                size: 100
                            )
                            
                            VStack(spacing: 4) {
                                Text(currentUser?.username ?? "User")
                                    .font(AppTheme.title)
                                    .fontWeight(.bold)
                                
                                Text(currentUser?.bio ?? "")
                                    .font(AppTheme.callout)
                                    .foregroundColor(AppTheme.secondaryText)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            
                            // Stats
                            HStack(spacing: 32) {
                                StatView(value: userPosts.count, label: "Posts")
                                StatView(value: currentUser?.followersCount ?? 0, label: "Followers")
                                StatView(value: currentUser?.followingCount ?? 0, label: "Following")
                            }
                            
                            // Coin Balance & Recharge
                            HStack(spacing: 12) {
                                HStack(spacing: 4) {
                                    Image(systemName: "bitcoinsign.circle.fill")
                                        .foregroundColor(.yellow)
                                    Text("\(currentUser?.coins ?? 0)")
                                        .font(AppTheme.headline)
                                        .fontWeight(.bold)
                                    Text("Coins")
                                        .font(AppTheme.caption)
                                        .foregroundColor(AppTheme.secondaryText)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(AppTheme.secondaryBackground)
                                .cornerRadius(16)
                                
                                Button(action: {
                                    showingCoinStore = true
                                }) {
                                    Text("Recharge")
                                        .font(AppTheme.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(AppTheme.primaryBlue)
                                        .cornerRadius(16)
                                }
                            }
                            .padding(.top, 4)
                            
                            // Edit profile button
                            CustomButton(title: "Edit Profile", style: .outline) {
                                showingEditProfile = true
                            }
                            .padding(.horizontal, 40)
                        }
                        .padding()
                        .background(AppTheme.cardBackground)
                        .cornerRadius(AppTheme.cornerRadiusLarge)
                        .padding()
                        
                        // Posts grid
                        if !userPosts.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Your Posts")
                                    .font(AppTheme.headline)
                                    .padding(.horizontal)
                                
                                // Custom Grid for iOS 13
                                gridView(posts: userPosts)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationBarTitle(Text("Profile"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    showingSettings = true
                }) {
                    Image(systemName: "gearshape") // Check if gearshape exists in iOS 13. "gear" does. "gearshape" is iOS 14.
                        .foregroundColor(AppTheme.primaryBlue)
                }
            )
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
                    .environmentObject(authViewModel)
            }
            
            // iOS 13 only supports one sheet modifier per view hierarchy level effectively?
            // Actually multiple sheets on same view works if condition is exclusive or separate modifiers.
            // Using background empty view for second sheet is a common workaround for iOS 13 bugs.
            // But let's try direct first. If it fails, we fix.
        }
        // Workaround for multiple sheets: attach to background
        .background(
            EmptyView()
                .sheet(isPresented: $showingSettings) {
                    SettingsView()
                        .environmentObject(authViewModel)
                }
        )
        .background(
            EmptyView()
                .sheet(isPresented: $showingCoinStore) {
                    CoinStoreView()
                        .environmentObject(authViewModel)
                }
        )
    }
    
    // Custom Grid implementation
    func gridView(posts: [Post]) -> some View {
        let columns = 3
        let rows = (posts.count + columns - 1) / columns
        
        return VStack(spacing: 2) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<columns, id: \.self) { column in
                        let index = row * columns + column
                        if index < posts.count {
                            if let media = posts[index].firstMedia {
                                MediaViewer(mediaItem: media, aspectRatio: .fill)
                                    .frame(height: 120) // Fixed height to simulate grid
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            }
                        } else {
                            // Spacer for empty cells
                            Color.clear
                                .frame(height: 120)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
    }
}

struct StatView: View {
    let value: Int
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(AppTheme.headline)
                .fontWeight(.bold)
            
            Text(label)
                .font(AppTheme.caption)
                .foregroundColor(AppTheme.secondaryText)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
            .environmentObject(FeedViewModel())
    }
}
