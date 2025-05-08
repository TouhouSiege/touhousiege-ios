//
//  Characters.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-08.
//

import Foundation
import SwiftUI

struct Character: Identifiable {
    var id = UUID()
    var name: String
    var attack: Int
    let profilePicture: String
    let animationIdle: [String]
}

struct Characters {
    let allCharacters: [Character] = [
        Character(
            name: "Hakurei Reimu",
            attack: 10,
            profilePicture: TouhouSiegeStyle.Images.reimuHakureiProfile,
            animationIdle: TouhouSiegeStyle.Images.reimuHakureiIdle
        ),
    
        Character(
            name: "Kochiya Sanae",
            attack: 10,
            profilePicture: TouhouSiegeStyle.Images.tenshiHinanawiProfile,
            animationIdle: TouhouSiegeStyle.Images.tenshiHinanawiIdle
        ),
    
        Character(
            name: "Hijiri Byakuren",
            attack: 10,
            profilePicture: TouhouSiegeStyle.Images.hijiriByakurenProfile,
            animationIdle: TouhouSiegeStyle.Images.hijiriByakurenIdle
        )
    ]
}
