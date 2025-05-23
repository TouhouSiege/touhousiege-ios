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
    
    /// Single Gacha roll plus check for diamonds before roll
    func rollOneCharacter() async {
        guard let diamondCheck = user?.diamonds else { return }
        guard diamondCheck > 100 else { return print("Too little diamonds!") }
        
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.gachaRollOne(userId: userId, character: [
                Characters.allCharacters[0]
            ])
            print("Characters updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating characters: \(error)")
        }
    }
    
    /// Ten Gacha roll plus check for diamonds before roll
    func rollTenCharacters() async {
        guard let diamondCheck = user?.diamonds else { return }
        guard diamondCheck > 1000 else { return print("Too little diamonds!") }
        
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let response = try await apiManager?.gachaRollTen(userId: userId, characters: [
                Characters.allCharacters[0],
                Characters.allCharacters[1],
                Characters.allCharacters[2],
                Characters.allCharacters[3],
                Characters.allCharacters[4]
            ])
            print("Characters updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating characters: \(error)")
        }
    }
}
