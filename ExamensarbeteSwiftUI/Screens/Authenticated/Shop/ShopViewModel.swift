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
    }
}
