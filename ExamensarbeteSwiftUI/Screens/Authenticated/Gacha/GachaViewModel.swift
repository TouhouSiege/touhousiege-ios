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
    
    @Published var rolledCharacters: [String] = []
    
    /// Single Gacha roll plus check for diamonds before roll
    func rollOneCharacter() async {
        guard let diamondCheck = user?.diamonds else { return }
        guard diamondCheck > 100 else { return print("Too little diamonds!") }
        
        do {
            guard let userId = user?.id else {
                print("No user id found.")
                return
            }
            
            let randomCharacter = Characters.allCharacters.prefix(Characters.allCharacters.count / 2).randomElement()!
            
            let response = try await apiManager?.gachaRollOne(userId: userId, character: [randomCharacter])
            
            rolledCharacters.append(randomCharacter.name)
            
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

            let randomCharacters = (0..<10).map { _ in Characters.allCharacters.prefix(Characters.allCharacters.count / 2).randomElement()! }
            
            let response = try await apiManager?.gachaRollTen(userId: userId, characters: randomCharacters)
            
            rolledCharacters.append(contentsOf: randomCharacters.map { $0.name } )
            
            print("Characters updated successfully: \(String(describing: response))")
        } catch let error {
            print("Error updating characters: \(error)")
        }
    }
}
