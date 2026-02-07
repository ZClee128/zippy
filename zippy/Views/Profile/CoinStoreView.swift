//
//  CoinStoreView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct CoinStoreView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject private var storeManager = StoreManager()
    @State private var isPurchasing = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            AppTheme.lightOceanGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header with balance
                HStack {
                    Text("Coin Store")
                        .font(AppTheme.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "bitcoinsign.circle.fill")
                            .foregroundColor(.yellow)
                        Text("\(authViewModel.currentUser?.coins ?? 0)")
                            .font(AppTheme.headline)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(16)
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(storeManager.products) { product in
                            ProductRow(product: product) {
                                purchase(product)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            if isPurchasing {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    ActivityIndicator(style: .large)
                    Text("Processing Purchase...")
                        .foregroundColor(.white)
                        .font(AppTheme.headline)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Purchase"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func purchase(_ product: Product) {
        isPurchasing = true
        storeManager.purchaseProduct(product) { success in
            isPurchasing = false
            if success {
                authViewModel.addCoins(product.totalCoins)
                alertMessage = "Successfully purchased \(product.totalCoins) coins!"
                showAlert = true
            } else {
                alertMessage = "Purchase failed. Please try again."
                showAlert = true
            }
        }
    }
}

struct ProductRow: View {
    let product: Product
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name)
                        .font(AppTheme.headline)
                        .foregroundColor(AppTheme.primaryText)
                    
                    if product.bonusCoins > 0 {
                        Text("+ \(product.bonusCoins) Bonus")
                            .font(AppTheme.caption)
                            .foregroundColor(AppTheme.accentCoral)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Text(product.priceString)
                    .font(AppTheme.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(AppTheme.primaryBlue)
                    .cornerRadius(20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
