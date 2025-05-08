//
//  ApiModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-04-29.
//

import Foundation

/// POST, login
struct LoginRequest: Encodable {
    var email: String
    var password: String
}

/// POST, register
struct RegisterRequest: Encodable {
    var email: String
    var username: String
    var password: String
    var stamina: Int = 100
    var diamonds: Int = 0
    var gold: Int = 0
    var characters: Array<Int> = []
    var defense: Array<Int> = []
    var rankingNormalPvp: Int = 0
    var rankingColloseum: Int = 0
}

/// PUT, update characters
struct UpdateCharactersRequest: Codable {
    var characters: Array<Int>
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
    var token: String
    var username: String
}

struct CharacterUpdateResponse: Decodable {
    let success: Bool
    let message: String
}

