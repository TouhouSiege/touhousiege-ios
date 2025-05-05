//
//  User.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-05.
//

import Foundation

struct User: Decodable {
    var id: Int
    var email: String
    var username: String
    var stamina: Int
    var diamonds: Int
    var gold: Int
    var characters: [Int]
    var defense: [Int]
    var rankingNormalPvp: Int
    var rankingColloseum: Int
}
