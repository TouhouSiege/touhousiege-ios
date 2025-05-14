//
//  Characters.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-08.
//

import Foundation
import SwiftUI

class Character: Identifiable {
    var id: Int
    var name: String
    var team: Team
    var stats: Stats
    let profilePicture: ProfilePicture
    let animations: Animations
    
    init(id: Int, name: String, team: Team, stats: Stats, profilePicture: ProfilePicture, animations: Animations) {
        self.id = id
        self.name = name
        self.team = team
        self.stats = stats
        self.profilePicture = profilePicture
        self.animations = animations
    }
    
    class Stats {
        var attack: Int
        var defense: Int
        var hp: Int
        var speed: Int
        var classType: ClassType
        var attackType: AttackType
        
        init(attack: Int, defense: Int, hp: Int, speed: Int, classType: ClassType, attackType: AttackType) {
            self.attack = attack
            self.defense = defense
            self.hp = hp
            self.speed = speed
            self.classType = classType
            self.attackType = attackType
        }
    }
    
    class ProfilePicture {
        let small: String
        let big: String
        
        init(small: String, big: String) {
            self.small = small
            self.big = big
        }
    }
    
    class Animations {
        var idle: [String]
        var attack: [String]
        var faint: [String]
        var moveForward: [String]
        var moveBackward: [String]
        var getHit: [String]
        
        init(idle: [String], attack: [String], faint: [String], moveForward: [String], moveBackward: [String], getHit: [String]) {
            self.idle = idle
            self.attack = attack
            self.faint = faint
            self.moveForward = moveForward
            self.moveBackward = moveBackward
            self.getHit = getHit
        }
    }
    
    enum Team: String {
        case player
        case enemy
    }
    
    enum ClassType: String {
        case warrior
        case mage
        case assassin
    }
    
    // This will serve as your targeting preference:
    enum AttackType: String {
        case front
        case skip
        case back
    }
}


struct Characters {
    static let allCharacters: [Character] = [
        /// PLAYER - Characters
        Character(
            id: 1,
            name: "Hakurei Reimu",
            team: .player,
            stats: Character.Stats(
                attack: 30,
                defense: 0,
                hp: 100,
                speed: 110,
                classType: .mage,
                attackType: .front
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.reimuHakureiProfileSmall,
                big: TouhouSiegeStyle.Images.reimuHakureiProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.reimuHakureiIdle,
                attack: TouhouSiegeStyle.Images.reimuHakureiAttack,
                faint: TouhouSiegeStyle.Images.reimuHakureiFaint,
                moveForward: TouhouSiegeStyle.Images.reimuHakureiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reimuHakureiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reimuHakureiGetHit
            )
        ),
    
        Character(
            id: 2,
            name: "Tenshi Hinanawi",
            team: .player,
            stats: Character.Stats(
                attack: 30,
                defense: 0,
                hp: 80,
                speed: 120,
                classType: .warrior,
                attackType: .front
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.tenshiHinanawiProfileSmall,
                big: TouhouSiegeStyle.Images.tenshiHinanawiProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.tenshiHinanawiIdle,
                attack: TouhouSiegeStyle.Images.tenshiHinanawiAttack,
                faint: TouhouSiegeStyle.Images.tenshiHinanawiFaint,
                moveForward: TouhouSiegeStyle.Images.tenshiHinanawiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.tenshiHinanawiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.tenshiHinanawiGetHit
                )
        ),
    
        Character(
            id: 3,
            name: "Hijiri Byakuren",
            team: .player,
            stats: Character.Stats(
                attack: 30,
                defense: 0,
                hp: 120,
                speed: 100,
                classType: .mage,
                attackType: .skip
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.hijiriByakurenProfileSmall,
                big: TouhouSiegeStyle.Images.hijiriByakurenProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.hijiriByakurenIdle,
                attack: TouhouSiegeStyle.Images.hijiriByakurenAttack,
                faint: TouhouSiegeStyle.Images.hijiriByakurenFaint,
                moveForward: TouhouSiegeStyle.Images.hijiriByakurenMoveForward,
                moveBackward: TouhouSiegeStyle.Images.hijiriByakurenMoveBackwards,
                getHit: TouhouSiegeStyle.Images.hijiriByakurenGetHit
                )
        ),
        
        Character(
            id: 4,
            name: "Koishi Komeiji",
            team: .player,
            stats: Character.Stats(
                attack: 24,
                defense: 10,
                hp: 200,
                speed: 60,
                classType: .mage,
                attackType: .back
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.koishiKomeijiProfileSmall,
                big: TouhouSiegeStyle.Images.koishiKomeijiProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.koishiKomeijiIdle,
                attack: TouhouSiegeStyle.Images.koishiKomeijiAttack,
                faint: TouhouSiegeStyle.Images.koishiKomeijiFaint,
                moveForward: TouhouSiegeStyle.Images.koishiKomeijiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.koishiKomeijiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.koishiKomeijiGetHit
                )
            ),
        
        Character(
            id: 5,
            name: "Reisen Udongein Inaba",
            team: .player,
            stats: Character.Stats(
                attack: 40,
                defense: 2,
                hp: 76,
                speed: 130,
                classType: .mage,
                attackType: .back
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileSmall,
                big: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.reisenUdongeinInabaIdle,
                attack: TouhouSiegeStyle.Images.reisenUdongeinInabaAttack,
                faint: TouhouSiegeStyle.Images.reisenUdongeinInabaFaint,
                moveForward: TouhouSiegeStyle.Images.reisenUdongeinInabaMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reisenUdongeinInabaMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reisenUdongeinInabaGetHit
                )
            ),
        
        /// ENEMY Characters
        Character(
            id: 101,
            name: "Hakurei Reimu",
            team: .enemy,
            stats: Character.Stats(
                attack: 30,
                defense: 0,
                hp: 100,
                speed: 110,
                classType: .mage,
                attackType: .front
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.reimuHakureiProfileSmall,
                big: TouhouSiegeStyle.Images.reimuHakureiProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.reimuHakureiIdle,
                attack: TouhouSiegeStyle.Images.reimuHakureiAttack,
                faint: TouhouSiegeStyle.Images.reimuHakureiFaint,
                moveForward: TouhouSiegeStyle.Images.reimuHakureiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reimuHakureiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reimuHakureiGetHit
            )
        ),
    
        Character(
            id: 102,
            name: "Tenshi Hinanawi",
            team: .enemy,
            stats: Character.Stats(
                attack: 30,
                defense: 0,
                hp: 80,
                speed: 120,
                classType: .warrior,
                attackType: .front
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.tenshiHinanawiProfileSmall,
                big: TouhouSiegeStyle.Images.tenshiHinanawiProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.tenshiHinanawiIdle,
                attack: TouhouSiegeStyle.Images.tenshiHinanawiAttack,
                faint: TouhouSiegeStyle.Images.tenshiHinanawiFaint,
                moveForward: TouhouSiegeStyle.Images.tenshiHinanawiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.tenshiHinanawiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.tenshiHinanawiGetHit
                )
        ),
    
        Character(
            id: 103,
            name: "Hijiri Byakuren",
            team: .enemy,
            stats: Character.Stats(
                attack: 30,
                defense: 0,
                hp: 120,
                speed: 100,
                classType: .mage,
                attackType: .skip
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.hijiriByakurenProfileSmall,
                big: TouhouSiegeStyle.Images.hijiriByakurenProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.hijiriByakurenIdle,
                attack: TouhouSiegeStyle.Images.hijiriByakurenAttack,
                faint: TouhouSiegeStyle.Images.hijiriByakurenFaint,
                moveForward: TouhouSiegeStyle.Images.hijiriByakurenMoveForward,
                moveBackward: TouhouSiegeStyle.Images.hijiriByakurenMoveBackwards,
                getHit: TouhouSiegeStyle.Images.hijiriByakurenGetHit
                )
        ),
        
        Character(
            id: 104,
            name: "Koishi Komeiji",
            team: .enemy,
            stats: Character.Stats(
                attack: 24,
                defense: 10,
                hp: 200,
                speed: 60,
                classType: .mage,
                attackType: .back
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.koishiKomeijiProfileSmall,
                big: TouhouSiegeStyle.Images.koishiKomeijiProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.koishiKomeijiIdle,
                attack: TouhouSiegeStyle.Images.koishiKomeijiAttack,
                faint: TouhouSiegeStyle.Images.koishiKomeijiFaint,
                moveForward: TouhouSiegeStyle.Images.koishiKomeijiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.koishiKomeijiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.koishiKomeijiGetHit
                )
            ),
        
        Character(
            id: 105,
            name: "Reisen Udongein Inaba",
            team: .enemy,
            stats: Character.Stats(
                attack: 40,
                defense: 2,
                hp: 76,
                speed: 130,
                classType: .mage,
                attackType: .back
            ),
            profilePicture: Character.ProfilePicture(
                small: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileSmall,
                big: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileLarge),
            animations: Character.Animations(
                idle: TouhouSiegeStyle.Images.reisenUdongeinInabaIdle,
                attack: TouhouSiegeStyle.Images.reisenUdongeinInabaAttack,
                faint: TouhouSiegeStyle.Images.reisenUdongeinInabaFaint,
                moveForward: TouhouSiegeStyle.Images.reisenUdongeinInabaMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reisenUdongeinInabaMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reisenUdongeinInabaGetHit
                )
            )
    ]
}
