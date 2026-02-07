//
//  SettingsView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingLogoutAlert = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.lightOceanGradient
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    Section(header: Text("Account")) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(AppTheme.primaryBlue)
                            Text(authViewModel.currentUser?.email ?? "")
                        }
                        
                        Button(action: {
                            showingLogoutAlert = true
                        }) {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(AppTheme.accentCoral)
                                Text("Delete Account")
                                    .foregroundColor(AppTheme.accentCoral)
                            }
                        }
                    }
                    
                    Section(header: Text("About")) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(AppTheme.primaryBlue)
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(AppTheme.secondaryText)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Delete Account"),
                    message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        authViewModel.deleteAccount()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
