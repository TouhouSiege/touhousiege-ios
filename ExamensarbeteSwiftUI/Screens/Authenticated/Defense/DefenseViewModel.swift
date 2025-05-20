//
//  DefenseViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-20.
//

import Foundation

class DefenseViewModel {
    var apiManager: ApiAuthManager?
    var user: User?
    
    /// Temporary roll
    func updateDefense(defense: [Int]) async {
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            let response = try await apiManager?.setDefense(userId: userId, defense: defense)
            print("Defense updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating defense: \(error)")
        }
    }
}
