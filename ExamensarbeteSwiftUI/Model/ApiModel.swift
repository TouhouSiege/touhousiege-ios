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
    var stamina: Int = 100
    var diamonds: Int = 0
    var gold: Int = 0
    var characters: Array<Int> = []
    var defense: Array<Int> = []
    var rankingNormalPvp: Int = 0
    var rankingColloseum: Int = 0
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
    var token: String
}
