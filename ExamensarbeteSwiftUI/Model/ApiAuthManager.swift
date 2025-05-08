//
//  ApiViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-05.
//

import Foundation
import KeychainSwift

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
        let registerPayload = RegisterRequest(email: email, username: username, password: password)
        
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
    
    func tempGetCharacters(userId: Int, characters: [Int]) async throws -> CharacterUpdateResponse {
        let updateCharacterRequest = UpdateCharactersRequest(characters: characters)

        let response: CharacterUpdateResponse = try await api.put(
            url: "\(BASE_URL)/update-characters?id=\(userId)",
            body: updateCharacterRequest,
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
