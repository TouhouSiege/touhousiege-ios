//
//  ShopViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-25.
//

import Foundation

class ShopViewModel {
    var apiManager: ApiAuthManager?
    var user: User?
    var userManager: UserManager?
    
    /// Diamond purchase function
    func purchaseDiamonds(amount: Int) async {
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.updateDiamonds(userId: userId, diamonds: amount)
            print("Amount of Diamonds updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating amount of diamonds: \(error)")
        }
        
        do {
            guard let userManager = userManager else { return }
            
            try await userManager.getUser()
        } catch let error {
            print("Error loading user: \(error)")
        }
    }
    
    /// Stamina purchase function
    func purchaseStamina(amount: Int) async {
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.updateStamina(userId: userId, stamina: amount)
            print("Stamina updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating Stamina: \(error)")
        }
        
        do {
            guard let userManager = userManager else { return }
            
            try await userManager.getUser()
        } catch let error {
            print("Error loading user: \(error)")
        }
    }
}
