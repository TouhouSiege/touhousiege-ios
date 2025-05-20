//
//  GachaViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import Foundation

class GachaViewModel {
    var apiManager: ApiAuthManager?
    var user: User?
    
    /// Temporary roll
    func rollTenCharacters() async {
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            let response = try await apiManager?.tempGetCharacters(userId: userId, characters: [
                Characters.allCharacters[0].id,
                Characters.allCharacters[1].id,
                Characters.allCharacters[2].id,
                Characters.allCharacters[3].id,
                Characters.allCharacters[4].id
            ])
            print("Characters updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating characters: \(error)")
        }
    }
}
