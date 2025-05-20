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
    var pvmWins: Int = 0
    var pvmLosses: Int = 0
    var pvpWins: Int = 0
    var pvpLosses: Int = 0
}

/// PUT, update characters
struct UpdateCharactersRequest: Codable {
    var characters: Array<Int>
}

/// PUT, update defense
struct UpdateDefenseRequest: Codable {
    var defense: Array<Int>
}

/// GET, random player
struct GetRandomPlayerDefense: Codable {
    var user: User
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
    var token: String
    var username: String
}

struct GeneralUpdateResponse: Decodable {
    let success: Bool
    let message: String
}

struct GetRandomPlayerReponse: Decodable {
    let success: Bool
    let user: User?
    let message: String
}

