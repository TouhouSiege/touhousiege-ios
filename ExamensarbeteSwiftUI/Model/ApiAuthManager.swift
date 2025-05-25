//
//  ApiViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-05.
//

import Foundation
import KeychainSwift
import SwiftUICore

class ApiAuthManager: ObservableObject {
    @Published var token: String? = nil
    @Published var username: String? = nil
    
    
    let api = Api()
    let keychain = KeychainSwift()
    
    let BASE_URL = "http://localhost:8080/api/v1/user"
    
    init() {
        self.token = keychain.get("token")
        self.username = keychain.get("username")
    }
    
    func register(email: String, username: String, password: String) async throws {
        let registerPayload = RegisterRequest(email: email, username: username, password: password, characters: [], defense: [])
        
        let response: AuthResponse = try await api.post(url: "\(BASE_URL)/register", body: registerPayload, token: nil)
        
        DispatchQueue.main.async {
            self.token = response.token
            self.username = response.username
            self.keychain.set(response.token, forKey: "token")
            self.keychain.set(response.username, forKey: "username")
        }
    }
    
    func loginUser(email: String, password: String) async throws -> AuthResponse {
        let loginPayload = LoginRequest(email: email, password: password)
        
        let response: AuthResponse = try await api.post(url: "\(BASE_URL)/login", body: loginPayload, token: nil)
        
        DispatchQueue.main.async {
            self.token = response.token
            self.username = response.username
            self.keychain.set(response.token, forKey: "token")
            self.keychain.set(response.username, forKey: "username")
        }
        
        return response
    }
    
    func tempGetCharacters(userId: Int, characters: [Int]) async throws -> GeneralUpdateResponse {
        let updateCharacterRequest = UpdateCharactersRequest(characters: characters)

        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-characters?id=\(userId)",
            body: updateCharacterRequest,
            token: token
        )

        return response
    }
    
    func gachaRollTen(userId: Int, characters: [GameCharacter]) async throws -> GeneralUpdateResponse {
        let gachaRollConverted: [CharacterData] = characters.map { $0.toCharacterData() }
        
        let updateCharacterRequest = UpdateCharactersUniqueRequest(characters: gachaRollConverted)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-characters?id=\(userId)",
            body: updateCharacterRequest,
            token: token
            )
        
        return response
    }
    
    func gachaRollOne(userId: Int, character: [GameCharacter]) async throws -> GeneralUpdateResponse {
        let gachaRollConverted: [CharacterData] = character.map { $0.toCharacterData() }
        
        let updateCharacterRequest = UpdateCharactersUniqueRequest(characters: gachaRollConverted)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-characters?id=\(userId)",
            body: updateCharacterRequest,
            token: token
            )
        
        return response
    }
    
    func setDefense(userId: Int, defense: [GameCharacter?]) async throws -> GeneralUpdateResponse {
        let defenseConverted: [CharacterData?] = defense.map { $0?.toCharacterData() }
        
        let updateDefenseRequest = UpdateDefenseRequest(defense: defenseConverted)

        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-defense?id=\(userId)",
            body: updateDefenseRequest,
            token: token
        )

        return response
    }
    
    func updateDiamonds(userId: Int, diamonds: Int) async throws -> GeneralUpdateResponse {
        let updateDiamondsRequest = UpdateDiamondsRequest(diamonds: diamonds)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-diamonds?id=\(userId)",
            body: updateDiamondsRequest,
            token: token
        )
        
        return response
    }
    
    func updateDiamondsSubtract(userId: Int, diamonds: Int) async throws -> GeneralUpdateResponse {
        let updateDiamondsRequest = UpdateDiamondsRequest(diamonds: diamonds)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-diamonds-subtract?id=\(userId)",
            body: updateDiamondsRequest,
            token: token
        )
        
        return response
    }
    
    func updateStamina(userId: Int, stamina: Int) async throws -> GeneralUpdateResponse {
        let updateStaminaRequest = UpdateStaminaRequest(stamina: stamina)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-stamina?id=\(userId)",
            body: updateStaminaRequest,
            token: token
        )
        
        return response
    }
    
    func updateGold(userId: Int, gold: Int) async throws -> GeneralUpdateResponse {
        let updateGoldRequest = UpdateGoldRequest(gold: gold)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-gold?id=\(userId)",
            body: updateGoldRequest,
            token: token
        )
        
        return response
    }
    
    func updateGoldSubtract(userId: Int, gold: Int) async throws -> GeneralUpdateResponse {
        let updateGoldRequest = UpdateGoldRequest(gold: gold)
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-gold-subtract?id=\(userId)",
            body: updateGoldRequest,
            token: token
        )
        
        return response
    }
    
    func getRandomPlayer(user: User) async throws -> GetRandomPlayerReponse {
        let getRandomPlayer = GetRandomPlayerDefense(user: user)
        
        let response: GetRandomPlayerReponse = try await api.post(
            url: "\(BASE_URL)/random-enemy",
            body: getRandomPlayer,
            token: token
        )
        
        return response
    }
    
    func updateEndOfGame(userId: Int, caseGame: Int) async throws -> GeneralUpdateResponse {
        var updateEndOfGameRequest: UpdateEndOfGameRequest? = nil
        
        switch caseGame {
        case 1: updateEndOfGameRequest = UpdateEndOfGameRequest(caseGame: 1)
        case 2: updateEndOfGameRequest = UpdateEndOfGameRequest(caseGame: 2)
        case 3: updateEndOfGameRequest = UpdateEndOfGameRequest(caseGame: 3)
        case 4: updateEndOfGameRequest = UpdateEndOfGameRequest(caseGame: 4)
        default: print("Error, no end of game status was valid!")
        }
        
        guard let updateEndOfGameRequest = updateEndOfGameRequest else { return GeneralUpdateResponse(success: false, message: "Failed to find a valid number for case!") }
        
        let response: GeneralUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-end-of-game?id=\(userId)",
            body: updateEndOfGameRequest,
            token: token
        )

        return response
    }

    func logoutUser() {
        keychain.delete("token")
        keychain.delete("username")
        self.token = nil
        self.username = nil
    }
}
