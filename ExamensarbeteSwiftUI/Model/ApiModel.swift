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

/// POST, register new user
struct RegisterRequest: Codable {
    var email: String
    var username: String
    var password: String
    var stamina: Int = 100
    var diamonds: Int = 0
    var gold: Int = 0
    var characters: [CharacterData]
    var defense: [CharacterData?]
    var rankingNormalPvp: Int = 0
    var rankingColloseum: Int = 0
    var pvmWins: Int = 0
    var pvmLosses: Int = 0
    var pvpWins: Int = 0
    var pvpLosses: Int = 0
}

struct CharacterData: Codable {
    var name: String
    var team: String
    var stats: StatsData
    var profilePicture: ProfilePictureData
    var animations: AnimationsData
}

struct StatsData: Codable {
    var attack: Int
    var defense: Int
    var maxHp: Int
    var currentHp: Int
    var speed: Int
    var classType: String
    var attackType: String
}

struct ProfilePictureData: Codable {
    var small: String
    var big: String
}

struct AnimationsData: Codable {
    var idle: [String]
    var attack: [String]
    var faint: [String]
    var moveForward: [String]
    var moveBackward: [String]
    var getHit: [String]
}

/// PUT, update characters
struct UpdateCharactersRequest: Codable {
    var characters: Array<Int>
}

/// PUT, update characters, OBJECT not ids
struct UpdateCharactersUniqueRequest: Codable {
    var characters: [CharacterData]
}

/// PUT, update defense
struct UpdateDefenseRequest: Codable {
    var defense: [CharacterData?]
}

/// PUT, update diamonds
struct UpdateDiamondsRequest: Codable {
    var diamonds: Int
}

/// PUT, update stamina
struct UpdateStaminaRequest: Codable {
    var stamina: Int
}

/// PUT, update rankings pvm win
struct UpdateEndOfGameRequest: Codable {
    var caseGame: Int
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

