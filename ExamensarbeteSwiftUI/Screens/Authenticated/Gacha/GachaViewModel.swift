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
    
    /// Single Gacha roll
    func rollOneCharacter() async {
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
    
    /// Ten Gacha roll
    func rollTenCharacters() async {
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
