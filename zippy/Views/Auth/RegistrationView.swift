//
//  RegistrationView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(AppTheme.primaryBlue)
                        
                        Text("Create Account")
                            .font(AppTheme.title)
                            .fontWeight(.bold)
                        
                        Text("Join the fish lovers community!")
                            .font(AppTheme.callout)
                            .foregroundColor(AppTheme.secondaryText)
                    }
                    .padding(.top, AppTheme.paddingXLarge)
                    
                    // Registration form
                    VStack(spacing: 16) {
                        CustomTextField(
                            label: "Username",
                            placeholder: "Choose a username",
                            text: $username
                        )
                        
                        CustomTextField(
                            label: "Email",
                            placeholder: "Enter your email",
                            text: $email
                        )
                        
                        CustomTextField(
                            label: "Password",
                            placeholder: "Create a password",
                            text: $password,
                            isSecure: true
                        )
                        
                        CustomTextField(
                            label: "Confirm Password",
                            placeholder: "Confirm your password",
                            text: $confirmPassword,
                            isSecure: true
                        )
                        
                        CustomButton(title: "Sign Up", style: .primary) {
                            handleRegistration()
                        }
                        .padding(.top, AppTheme.paddingMedium)
                    }
                    .padding(.horizontal, AppTheme.paddingLarge)
                }
            }
            .background(AppTheme.lightOceanGradient.edgesIgnoringSafeArea(.all))
            // Title is set by parent or we can set it here if needed
            // For iOS 13, displayMode is part of navigationBarTitle
            .navigationBarTitle(Text("Create Account"), displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Registration Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func handleRegistration() {
        // Validation
        guard !username.isEmpty else {
            alertMessage = "Please enter a username"
            showingAlert = true
            return
        }
        
        guard !email.isEmpty else {
            alertMessage = "Please enter an email"
            showingAlert = true
            return
        }
        
        guard password.count >= 6 else {
            alertMessage = "Password must be at least 6 characters"
            showingAlert = true
            return
        }
        
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match"
            showingAlert = true
            return
        }
        
        // Attempt registration
        if authViewModel.register(username: username, email: email, password: password) {
            presentationMode.wrappedValue.dismiss()
        } else {
            alertMessage = "Email already in use. Please try another."
            showingAlert = true
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
