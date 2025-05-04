//
//  ApiModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-04-29.
//

import Foundation

/// POST, login
struct LoginRequest: Encodable {
    var username: String
    var password: String
}

/// POST, register
struct RegisterRequest: Encodable {
    var email: String
    var username: String
    var password: String
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
    var token: String
}
