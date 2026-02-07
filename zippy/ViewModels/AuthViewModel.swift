//
//  AuthViewModel.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private let dataService = DataService.shared
    
    init() {
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        currentUser = dataService.currentUser
        isAuthenticated = currentUser != nil
    }
    
    func login(email: String, password: String) -> Bool {
        let success = dataService.login(email: email, password: password)
        if success {
            currentUser = dataService.currentUser
            isAuthenticated = true
        }
        return success
    }
    
    func register(username: String, email: String, password: String) -> Bool {
        let success = dataService.register(username: username, email: email, password: password)
        if success {
            currentUser = dataService.currentUser
            isAuthenticated = true
        }
        return success
    }
    
    func logout() {
        dataService.logout()
        currentUser = nil
        isAuthenticated = false
    }
    
    func deleteAccount() {
        dataService.deleteUser()
        currentUser = nil
        isAuthenticated = false
    }
    
    func updateProfile(username: String, bio: String, avatarName: String) {
        dataService.updateProfile(username: username, bio: bio, avatarName: avatarName)
        currentUser = dataService.currentUser
    }
    
    func autoCreateAccount() {
        // Generate random user credentials
        let randomID = Int.random(in: 1000...9999)
        let username = "User\(randomID)"
        let email = "user\(randomID)@zippy.com"
        let password = UUID().uuidString // Random password
        
        // Attempt to register
        if register(username: username, email: email, password: password) {
            // Success - register method already sets currentUser and isAuthenticated
            print("Auto-account created: \(username)")
        } else {
            // Retry on collision (rare but possible)
            autoCreateAccount()
        }
    }
    
    func addCoins(_ amount: Int) {
        dataService.addCoins(amount)
        currentUser = dataService.currentUser // Refresh local user state
    }
    
    func deductCoins(_ amount: Int) -> Bool {
        let success = dataService.deductCoins(amount)
        if success {
            currentUser = dataService.currentUser
        }
        return success
    }
}
