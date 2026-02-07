# Zippy - 鱼友社交中心 Fish Lovers Social Hub

Zippy is a comprehensive social media app for fish enthusiasts worldwide! Share photos and videos of your aquatic tanks, discover expert insights, connect with fellow aquarists, and celebrate your finned friends.

## ✨ Features

- 🔐 **Authentication**: Login and registration with profile management
- 📱 **Feed**: Browse and create posts with photos, captions, and tags
- 💬 **Chat**: Real-time messaging with fellow fish lovers
- 🔍 **Discovery**: Explore trending content, expert insights, and aquatic supplies
- 👤 **Profile**: Manage your profile, view stats, and showcase your posts
- 🎨 **Beautiful UI**: Ocean-themed design with custom gradients and components

## 🏗️ Architecture

Built with **SwiftUI** using MVVM pattern:
- **Models**: User, Post, Message, Conversation
- **ViewModels**: AuthViewModel, FeedViewModel, ChatViewModel
- **Services**: DataService (persistence), MockDataService (sample data)
- **Components**: Reusable UI components with consistent styling

## 🚀 Getting Started

1. **Open in Xcode**:
   ```bash
   open zippy.xcodeproj
   ```

2. **Configure Signing**:
   - Select zippy target
   - Go to "Signing & Capabilities"
   - Enable "Automatically manage signing"
   - Select your team

3. **Run**:
   - Choose iPhone simulator
   - Press ⌘R to build and run

## 📦 What's Included

- ✅ Complete authentication flow
- ✅ Feed with 10 sample posts
- ✅ Chat with 3 pre-configured conversations
- ✅ Profile management with avatar editing
- ✅ Discovery page with expert insights
- ✅ 8 colorful fish placeholder images
- ✅ 5 avatar placeholders
- ✅ Ocean-themed design system

## 🎯 Test Users

The app comes with 5 pre-configured users:
- **OceanExplorer** - Marine biologist
- **BettaLover** - Betta breeder
- **ReefMaster** - Saltwater reef expert
- **FreshwaterFan** - Planted tank enthusiast
- **Aquascaper** - Award-winning designer

## 📱 Screens

- Login & Registration
- Feed (Home)
- Create Post
- Discover
- Chat List
- Conversation
- Profile
- Edit Profile
- Settings

## 🛠️ Technology Stack

- SwiftUI
- Combine
- UserDefaults (data persistence)
- PhotosPicker (image selection)
- Custom gradient backgrounds
- MVVM architecture

## 📝 Notes

- Data is stored locally using UserDefaults
- Images are saved to app Documents directory
- Mock data is pre-populated on first launch
- All UI follows ocean-themed design system

## 🔮 Future Enhancements

- Backend integration (Firebase/Supabase)
- Real-time chat with WebSocket
- Video playback
- Comment threads
- Push notifications
- User search
- Follow/unfollow functionality

---

**Created with ❤️ for fish lovers worldwide 🐠🐟🐡**
