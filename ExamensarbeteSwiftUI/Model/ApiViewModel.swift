//
//  ApiViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-05.
//

import Foundation

class ApiViewModel: ObservableObject {
    @Published var token: String? = nil
    
    let api = Api()
    
    let BASE_URL = "http://localhost:8080/api/v1/user"
    
    func createUser(email: String, username: String, password: String) async throws -> AuthResponse {
        let registerPayload = RegisterRequest(email: email, username: username, password: password)
        
        let response: AuthResponse = try await api.post(url: "\(BASE_URL)", body: registerPayload, token: nil)
        
        DispatchQueue.main.async {
            self.token = response.token
        }
        
        return response
    }
    
    func loginUser(email: String, password: String) async throws -> AuthResponse {
        let loginPayload = LoginRequest(email: email, password: password)
        
        let response: AuthResponse = try await api.post(url: "\(BASE_URL)/login", body: loginPayload, token: nil)
        
        DispatchQueue.main.async {
            self.token = response.token
        }
        
        return response
    }
}
