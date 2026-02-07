//
//  WelcomeView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isAgreeing = false
    @State private var showingTerms = false
    
    var body: some View {
        ZStack {
            // Background
            AppTheme.lightOceanGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                
                // Logo or Title
                VStack(spacing: 16) {
                    Image(systemName: "fish.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(AppTheme.primaryBlue)
                    
                    Text("Welcome to Zippy")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(AppTheme.primaryBlue)
                    
                    Text("The social hub for fish lovers")
                        .font(.system(size: 18))
                        .foregroundColor(AppTheme.secondaryText)
                }
                
                Spacer()
                
                // Agreement Section
                VStack(spacing: 20) {
                    Text("By clicking 'Agree & Enter', you agree to our Terms of Service and Privacy Policy. An account will be automatically created for you.")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.secondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    if isAgreeing {
                        ActivityIndicator(style: .medium)
                    } else {
                        Button(action: {
                            isAgreeing = true
                            // Simulate network delay for better UX
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                authViewModel.autoCreateAccount()
                            }
                        }) {
                            Text("Agree & Enter")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.primaryBlue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 40)
                        
                        Button(action: {
                            showingTerms = true
                        }) {
                            Text("Read User Agreement & Privacy Policy")
                                .font(.caption)
                                .foregroundColor(AppTheme.primaryBlue)
                                .underline()
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .sheet(isPresented: $showingTerms) {
            TermsView()
        }
    }
}

// Simple Activity Indicator for iOS 13 compatibility
struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthViewModel())
    }
}
