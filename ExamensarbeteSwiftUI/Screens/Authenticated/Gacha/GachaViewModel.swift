//
//  GachaViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import Foundation

class GachaViewModel: ObservableObject {
    var apiManager: ApiAuthManager?
    var user: User?
    var userManager: UserManager?
    
    @Published var successfullyRolled: Bool = false
    @Published var rolledCharacters: [String] = []
    @Published var confirmDialogError = false
    
    /// Single Gacha roll plus check for diamonds before roll
    func rollOneCharacter() async {
        guard let diamondCheck = user?.diamonds else { return }
        guard diamondCheck > 100 else { return await MainActor.run { confirmDialogError = true } }
        
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let randomCharacter = Characters.allCharacters.prefix(Characters.allCharacters.count / 2).randomElement()!
            
            let response = try await apiManager?.gachaRollOne(userId: userId, character: [randomCharacter])
            
            await MainActor.run {
                rolledCharacters.append(randomCharacter.name)
                successfullyRolled = true
            }
            
            print("Characters updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating characters: \(error)")
        }
    }
    
    /// Ten Gacha roll plus check for diamonds before roll
    func rollTenCharacters() async {
        guard let diamondCheck = user?.diamonds else { return }
        guard diamondCheck > 1000 else { return await MainActor.run { confirmDialogError = true } }
        
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }

            let randomCharacters = (0..<10).map { _ in Characters.allCharacters.prefix(Characters.allCharacters.count / 2).randomElement()! }
            
            let response = try await apiManager?.gachaRollTen(userId: userId, characters: randomCharacters)
            
            await MainActor.run {
                rolledCharacters.append(contentsOf: randomCharacters.map { $0.name } )
                successfullyRolled = true
            }
            
            print("Characters updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating characters: \(error)")
        }
    }
}
