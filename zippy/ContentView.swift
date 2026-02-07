//
//  ContentView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State private var selectedTab = 0
    @State private var showingCreatePost = false
    
    // Custom binding for TabView to handle interception for "Post" tab
    var tabBinding: Binding<Int> {
        Binding(
            get: { self.selectedTab },
            set: {
                if $0 == 2 {
                    self.showingCreatePost = true
                } else {
                    self.selectedTab = $0
                }
            }
        )
    }
    
    var body: some View {
        TabView(selection: tabBinding) {
            // Feed Tab
            FeedView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Feed")
                }
                .tag(0)
            
            // Discover Tab
            DiscoverView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
                .tag(1)
            
            // Create Post Tab
            Color.clear
                .tabItem {
                    Image(systemName: "plus.app.fill")
                    Text("Post")
                }
                .tag(2)
            
            // Chat Tab
            ChatListView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
                .tag(3)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(AppTheme.primaryBlue)
        .sheet(isPresented: $showingCreatePost) {
            CreatePostView()
                .environmentObject(feedViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(FeedViewModel())
            .environmentObject(ChatViewModel())
    }
}

struct RootView: View {
    @ObservedObject var authViewModel: AuthViewModel
    // Passing these through to allow EnvironmentObject injection
    var feedViewModel: FeedViewModel
    var chatViewModel: ChatViewModel
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                ContentView()
                // Injecting EnvironmentObjects here for the whole app
                    .environmentObject(authViewModel)
                    .environmentObject(feedViewModel)
                    .environmentObject(chatViewModel)
            } else {
                WelcomeView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
