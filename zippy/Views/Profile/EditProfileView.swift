//
//  EditProfileView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI
import Combine

struct EditProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var bio: String = ""
    @State private var selectedAvatar: String = ""
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                    VStack(spacing: 24) {
                        // Avatar picker
                        VStack(spacing: 12) {
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                AvatarView(
                                    imageName: selectedAvatar,
                                    size: 100
                                )
                                .overlay(
                                    ZStack {
                                        Circle()
                                            .fill(Color.black.opacity(0.5))
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 22, weight: .bold))
                                    }
                                )
                            }
                            
                            Text("Tap to change avatar")
                                .font(AppTheme.caption)
                                .foregroundColor(AppTheme.secondaryText)
                        }
                        .padding(.top)
                        
                        // Form
                        VStack(spacing: 16) {
                            CustomTextField(
                                label: "Username",
                                placeholder: "Enter username",
                                text: $username
                            )
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Bio")
                                    .font(AppTheme.subheadline)
                                    .foregroundColor(AppTheme.secondaryText)
                                
                                // TextField for bio (simple)
                                TextField("Enter bio", text: $bio)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(AppTheme.secondaryBackground)
                                    .cornerRadius(AppTheme.cornerRadiusSmall)
                            }
                            
                            CustomButton(title: "Save Changes (10 Coins)", style: .primary) {
                                saveProfile()
                            }
                            .padding(.top)
                            
                            if let coins = authViewModel.currentUser?.coins {
                                Text("Current Balance: \(coins) Coins")
                                    .font(AppTheme.caption)
                                    .foregroundColor(AppTheme.secondaryText)
                            }
                        }
                        .padding(.horizontal, AppTheme.paddingLarge)
                    }
                }
                .background(AppTheme.lightOceanGradient.edgesIgnoringSafeArea(.all))
            .navigationBarTitle(Text("Edit Profile"), displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Update Profile"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
                    .onDisappear {
                        if let image = selectedImage {
                            // Save immediately when picker dismissed with selection
                            if let filename = DataService.shared.saveImage(image) {
                                selectedAvatar = filename
                            }
                        }
                    }
            }
            .onAppear {
                if let user = authViewModel.currentUser {
                    username = user.username
                    bio = user.bio
                    selectedAvatar = user.avatarName
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func saveProfile() {
        if authViewModel.deductCoins(10) {
            authViewModel.updateProfile(
                username: username,
                bio: bio,
                avatarName: selectedAvatar
            )
            presentationMode.wrappedValue.dismiss()
        } else {
            alertMessage = "Insufficient coins! You need 10 coins to update your profile."
            showAlert = true
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(AuthViewModel())
    }
}
