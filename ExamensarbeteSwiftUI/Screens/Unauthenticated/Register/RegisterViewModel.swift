//
//  RegisterViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-04.
//

import Foundation

class RegisterViewModel {
    @Published var token: String? = nil
    
    let api = Api()
    
    let BASE_URL = "http://localhost:8080/api/v1/user"
    
    func createUser(email: String, username: String, password: String) async throws -> AuthResponse {
        let registerPayload = RegisterRequest(email: email, username: username, password: password)
        
        let response: AuthResponse = try await api.post(url: "\(BASE_URL)", body: registerPayload, token: nil)
        
        self.token = response.token
        
        return response
    }
}
