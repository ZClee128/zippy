//
//  StoreManager.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import Foundation
import Combine
import StoreKit

struct Product: Identifiable {
    let id: String
    let price: Double
    let coins: Int
    let bonusCoins: Int
    let name: String
    
    var totalCoins: Int {
        return coins + bonusCoins
    }
    
    var priceString: String {
        return "$\(price)"
    }
}

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published var products: [Product] = []
    
    private var skProducts: [SKProduct] = []
    private var request: SKProductsRequest?
    private var completion: ((Bool) -> Void)?
    
    override init() {
        super.init()
        self.products = [
            Product(id: "Zippy", price: 0.99, coins: 32, bonusCoins: 0, name: "32 coins"),
            Product(id: "Zippy1", price: 1.99, coins: 60, bonusCoins: 0, name: "60 coins"),
            Product(id: "Zippy2", price: 2.99, coins: 96, bonusCoins: 0, name: "96 coins"),
            Product(id: "Zippy4", price: 4.99, coins: 155, bonusCoins: 0, name: "155 coins"),
            Product(id: "Zippy5", price: 5.99, coins: 189, bonusCoins: 0, name: "189 coins"),
            Product(id: "Zippy9", price: 9.99, coins: 299, bonusCoins: 60, name: "359 coins"),
            Product(id: "Zippy19", price: 19.99, coins: 599, bonusCoins: 130, name: "729 coins"),
            Product(id: "Zippy49", price: 49.99, coins: 1599, bonusCoins: 270, name: "1869 coins"),
            Product(id: "Zippy99", price: 99.99, coins: 3199, bonusCoins: 600, name: "3799 coins")
        ]
        
        SKPaymentQueue.default().add(self)
        fetchProducts()
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    func fetchProducts() {
        let productIds = Set(products.map { $0.id })
        request = SKProductsRequest(productIdentifiers: productIds)
        request?.delegate = self
        request?.start()
    }
    
    // MARK: - SKProductsRequestDelegate
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.skProducts = response.products
            print("Fetched \(response.products.count) products")
        }
    }
    
    func purchaseProduct(_ product: Product, completion: @escaping (Bool) -> Void) {
        self.completion = completion
        
        // Try to find the real SKProduct
        if let skProduct = skProducts.first(where: { $0.productIdentifier == product.id }) {
            print("Initiating purchase for \(product.id)")
            let payment = SKPayment(product: skProduct)
            SKPaymentQueue.default().add(payment)
        } else {
            // Product not found -> Error (User requirements)
            print("Error: Product \(product.id) not found in StoreKit. Make sure Configuration.storekit is enabled in Xcode Scheme.")
            completion(false)
            self.completion = nil
        }
    }
    
    // MARK: - SKPaymentTransactionObserver
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Transaction purchased: \(transaction.payment.productIdentifier)")
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.completion?(true)
                    self.completion = nil
                }
                
            case .failed:
                print("Transaction failed: \(String(describing: transaction.error))")
                SKPaymentQueue.default().finishTransaction(transaction)
                
                var isSuccess = false
                if let error = transaction.error as? SKError {
                    if error.code == .paymentCancelled {
                        print("User cancelled.")
                        isSuccess = false
                    } else if error.code == .unknown {
                        // Often happens on login cancellation in simulator
                        print("Unknown error (possible login cancel).")
                        isSuccess = false
                    } else {
                        // Other errors -> Success (Simulator Only Requirement)
                        #if targetEnvironment(simulator)
                        print("Simulator bypass: Treating error '\(error.code)' as success.")
                        isSuccess = true
                        #else
                        isSuccess = false
                        #endif
                    }
                } else {
                    // Generic non-SKError
                     #if targetEnvironment(simulator)
                    print("Simulator bypass: Treating generic error as success.")
                    isSuccess = true
                    #else
                    isSuccess = false
                    #endif
                }
                
                DispatchQueue.main.async {
                    self.completion?(isSuccess)
                    self.completion = nil
                }
                
            case .restored:
                print("Transaction restored")
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.completion?(true)
                    self.completion = nil
                }
                
            case .purchasing, .deferred:
                break
                
            @unknown default:
                break
            }
        }
    }
}
