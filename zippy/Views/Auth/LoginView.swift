//
//  LoginView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var showingRegistration = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                AppTheme.oceanGradient
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo and title
                    VStack(spacing: 16) {
                        Image(systemName: "fish.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        
                        Text("Zippy")
                            .font(AppTheme.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Connect with fish lovers worldwide")
                            .font(AppTheme.callout)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    // Login form
                    VStack(spacing: 20) {
                        CustomTextField(
                            label: "Email",
                            placeholder: "Enter your email",
                            text: $email
                        )
                        
                        CustomTextField(
                            label: "Password",
                            placeholder: "Enter your password",
                            text: $password,
                            isSecure: true
                        )
                        
                        CustomButton(title: "Login", style: .primary) {
                            handleLogin()
                        }
                        
                        Button(action: {
                            showingRegistration = true
                        }) {
                            Text("Don't have an account? Sign Up")
                                .font(AppTheme.callout)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, AppTheme.paddingLarge)
                    .padding(.bottom, AppTheme.paddingXLarge)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text("Invalid email or password. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $showingRegistration) {
                RegistrationView()
                    .environmentObject(authViewModel)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func handleLogin() {
        if authViewModel.login(email: email, password: password) {
            // Success - view will update automatically via SceneDelegate switch
        } else {
            showingAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
