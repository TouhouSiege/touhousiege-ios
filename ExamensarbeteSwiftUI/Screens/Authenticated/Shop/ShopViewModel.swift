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
        /// Trying to purchase diamonds
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
        
        /// Updates user
        do {
            guard let userManager = userManager else { return }
            
            try await userManager.getUser()
        } catch let error {
            print("Error loading user: \(error)")
        }
    }
    
    /// Stamina purchase function
    func purchaseStamina(amount: Int, cost: Int) async {
        guard let goldCheck = user?.gold else { return }
        guard goldCheck >= cost else { return print("Too little Gold!") }
        
        /// Trying to purchase stamina
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
        
        /// Updating gold based on cost
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.updateGold(userId: userId, gold: cost)
            print("Gold updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating Gold: \(error)")
        }
        
        /// Updates user
        do {
            guard let userManager = userManager else { return }
            
            try await userManager.getUser()
        } catch let error {
            print("Error loading user: \(error)")
        }
    }
    
    /// Gold purchase function
    func purchaseGold(amount: Int, cost: Int) async {
        guard let diamondCheck = user?.diamonds else { return }
        guard diamondCheck > cost else { return print("Too little diamonds!") }
        
        /// Trying to purchase gold
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.updateGold(userId: userId, gold: amount)
            print("Amount of Gold updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating amount of Gold: \(error)")
        }
        
        /// Updates diamonds based on cost
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.updateDiamonds(userId: userId, diamonds: cost)
            print("Amount of Diamonds updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating amount of diamonds: \(error)")
        }
        
        /// Updates user
        do {
            guard let userManager = userManager else { return }
            
            try await userManager.getUser()
        } catch let error {
            print("Error loading user: \(error)")
        }
    }
}
