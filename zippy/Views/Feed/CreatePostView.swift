//
//  CreatePostView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI
import Combine

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: FeedViewModel
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var caption = ""
    @State private var tags = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Image picker
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - (AppTheme.paddingLarge * 2), height: 300)
                                .clipped()
                                .cornerRadius(AppTheme.cornerRadiusMedium)
                        } else {
                            ZStack {
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium)
                                    .fill(AppTheme.secondaryBackground)
                                    .frame(height: 300)
                                
                                VStack(spacing: 16) {
                                    Image(systemName: "photo.badge.plus")
                                        .font(.system(size: 60))
                                        .foregroundColor(AppTheme.primaryBlue)
                                    
                                    Text("Select Photo")
                                        .font(AppTheme.headline)
                                        .foregroundColor(AppTheme.primaryBlue)
                                }
                            }
                        }
                    }
                    
                    // Caption
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Caption")
                            .font(AppTheme.subheadline)
                            .foregroundColor(AppTheme.secondaryText)
                        
                        // TextEditor is available in iOS 14+. TextField for iOS 13 multiline is tricky.
                        // But actually TextEditor IS iOS 14.
                        // For iOS 13, need custom wrapper or just TextField.
                        // Let's use TextField for now for simplicity or CustomTextField.
                        TextField("Write a caption...", text: $caption)
                            .frame(height: 100)
                            .padding(8)
                            .background(AppTheme.secondaryBackground)
                            .cornerRadius(AppTheme.cornerRadiusSmall)
                    }
                    
                    // Tags
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tags (comma-separated)")
                            .font(AppTheme.subheadline)
                            .foregroundColor(AppTheme.secondaryText)
                        
                        TextField("e.g., clownfish, reef, saltwater", text: $tags)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Post button
                    CustomButton(title: "Post", style: .primary) {
                        handlePost()
                    }
                    .padding(.top, AppTheme.paddingMedium)
                }
                .padding(AppTheme.paddingLarge)
            }
            .background(AppTheme.lightOceanGradient.edgesIgnoringSafeArea(.all))
            .navigationBarTitle(Text("Create Post"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Post Created!"),
                    message: Text("Your post has been shared with the community!"),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func handlePost() {
        guard let image = selectedImage else { return }
        
        // Save image
        if let filename = DataService.shared.saveImage(image) {
            let media = MediaItem(type: .image, fileName: filename)
            let tagArray = tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            
            viewModel.createPost(media: [media], caption: caption, tags: tagArray)
            showingAlert = true
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .environmentObject(FeedViewModel())
    }
}
