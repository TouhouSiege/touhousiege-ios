//
//  Characters.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-08.
//

import Foundation
import SwiftUI

class GameCharacter: Identifiable, Codable {
    var id: Int?
    var name: String
    var team: Team
    var stats: Stats
    let profilePicture: ProfilePicture
    let animations: Animations
    
    init(id: Int?, name: String, team: Team, stats: Stats, profilePicture: ProfilePicture, animations: Animations) {
        self.id = id
        self.name = name
        self.team = team
        self.stats = stats
        self.profilePicture = profilePicture
        self.animations = animations
    }
    
    class Stats: Codable {
        var attack: Int
        var defense: Int
        var maxHp: Int
        var currentHp: Int
        var speed: Int
        var classType: ClassType
        var attackType: AttackType
        var level: Int
        
        init(attack: Int, defense: Int, maxHp: Int, currentHp: Int, speed: Int, classType: ClassType, attackType: AttackType, level: Int) {
            self.attack = attack
            self.defense = defense
            self.maxHp = maxHp
            self.currentHp = currentHp
            self.speed = speed
            self.classType = classType
            self.attackType = attackType
            self.level = level
        }
    }
    
    class ProfilePicture: Codable {
        let small: String
        let big: String
        
        init(small: String, big: String) {
            self.small = small
            self.big = big
        }
    }
    
    class Animations: Codable {
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
    
    enum Team: String, Codable {
        case player
        case enemy
    }
    
    enum ClassType: String, Codable {
        case Warrior
        case Mage
        case Assassin
    }
    
    enum AttackType: String, Codable {
        case Front
        case Skip
        case Back
    }
}


struct Characters {
    static let allCharacters: [GameCharacter] = [
        /// PLAYER - Characters
        GameCharacter(
            id: nil,
            name: "Hakurei Reimu",
            team: .player,
            stats: GameCharacter.Stats(
                attack: 35,
                defense: 20,
                maxHp: 100,
                currentHp: 100,
                speed: 110,
                classType: .Mage,
                attackType: .Front,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.reimuHakureiProfileSmall,
                big: TouhouSiegeStyle.Images.reimuHakureiProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.reimuHakureiIdle,
                attack: TouhouSiegeStyle.Images.reimuHakureiAttack,
                faint: TouhouSiegeStyle.Images.reimuHakureiFaint,
                moveForward: TouhouSiegeStyle.Images.reimuHakureiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reimuHakureiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reimuHakureiGetHit
            )
        ),
    
        GameCharacter(
            id: nil,
            name: "Tenshi Hinanawi",
            team: .player,
            stats: GameCharacter.Stats(
                attack: 30,
                defense: 28,
                maxHp: 160,
                currentHp: 160,
                speed: 120,
                classType: .Warrior,
                attackType: .Front,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.tenshiHinanawiProfileSmall,
                big: TouhouSiegeStyle.Images.tenshiHinanawiProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.tenshiHinanawiIdle,
                attack: TouhouSiegeStyle.Images.tenshiHinanawiAttack,
                faint: TouhouSiegeStyle.Images.tenshiHinanawiFaint,
                moveForward: TouhouSiegeStyle.Images.tenshiHinanawiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.tenshiHinanawiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.tenshiHinanawiGetHit
                )
        ),
    
        GameCharacter(
            id: nil,
            name: "Hijiri Byakuren",
            team: .player,
            stats: GameCharacter.Stats(
                attack: 42,
                defense: 12,
                maxHp: 140,
                currentHp: 140,
                speed: 100,
                classType: .Mage,
                attackType: .Skip,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.hijiriByakurenProfileSmall,
                big: TouhouSiegeStyle.Images.hijiriByakurenProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.hijiriByakurenIdle,
                attack: TouhouSiegeStyle.Images.hijiriByakurenAttack,
                faint: TouhouSiegeStyle.Images.hijiriByakurenFaint,
                moveForward: TouhouSiegeStyle.Images.hijiriByakurenMoveForward,
                moveBackward: TouhouSiegeStyle.Images.hijiriByakurenMoveBackwards,
                getHit: TouhouSiegeStyle.Images.hijiriByakurenGetHit
                )
        ),
        
        GameCharacter(
            id: nil,
            name: "Koishi Komeiji",
            team: .player,
            stats: GameCharacter.Stats(
                attack: 12,
                defense: 60,
                maxHp: 200,
                currentHp: 200,
                speed: 60,
                classType: .Mage,
                attackType: .Back,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.koishiKomeijiProfileSmall,
                big: TouhouSiegeStyle.Images.koishiKomeijiProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.koishiKomeijiIdle,
                attack: TouhouSiegeStyle.Images.koishiKomeijiAttack,
                faint: TouhouSiegeStyle.Images.koishiKomeijiFaint,
                moveForward: TouhouSiegeStyle.Images.koishiKomeijiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.koishiKomeijiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.koishiKomeijiGetHit
                )
            ),
        
        GameCharacter(
            id: nil,
            name: "Reisen Udongein Inaba",
            team: .player,
            stats: GameCharacter.Stats(
                attack: 60,
                defense: 5,
                maxHp: 70,
                currentHp: 70,
                speed: 130,
                classType: .Mage,
                attackType: .Back,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileSmall,
                big: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.reisenUdongeinInabaIdle,
                attack: TouhouSiegeStyle.Images.reisenUdongeinInabaAttack,
                faint: TouhouSiegeStyle.Images.reisenUdongeinInabaFaint,
                moveForward: TouhouSiegeStyle.Images.reisenUdongeinInabaMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reisenUdongeinInabaMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reisenUdongeinInabaGetHit
                )
            ),
        
        /// ENEMY Characters
        GameCharacter(
            id: 101,
            name: "Hakurei Reimu",
            team: .enemy,
            stats: GameCharacter.Stats(
                attack: 30,
                defense: 0,
                maxHp: 100,
                currentHp: 100,
                speed: 110,
                classType: .Mage,
                attackType: .Front,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.reimuHakureiProfileSmall,
                big: TouhouSiegeStyle.Images.reimuHakureiProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.reimuHakureiIdle,
                attack: TouhouSiegeStyle.Images.reimuHakureiAttack,
                faint: TouhouSiegeStyle.Images.reimuHakureiFaint,
                moveForward: TouhouSiegeStyle.Images.reimuHakureiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.reimuHakureiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.reimuHakureiGetHit
            )
        ),
    
        GameCharacter(
            id: 102,
            name: "Tenshi Hinanawi",
            team: .enemy,
            stats: GameCharacter.Stats(
                attack: 30,
                defense: 0,
                maxHp: 160,
                currentHp: 160,
                speed: 120,
                classType: .Warrior,
                attackType: .Front,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.tenshiHinanawiProfileSmall,
                big: TouhouSiegeStyle.Images.tenshiHinanawiProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.tenshiHinanawiIdle,
                attack: TouhouSiegeStyle.Images.tenshiHinanawiAttack,
                faint: TouhouSiegeStyle.Images.tenshiHinanawiFaint,
                moveForward: TouhouSiegeStyle.Images.tenshiHinanawiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.tenshiHinanawiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.tenshiHinanawiGetHit
                )
        ),
    
        GameCharacter(
            id: 103,
            name: "Hijiri Byakuren",
            team: .enemy,
            stats: GameCharacter.Stats(
                attack: 30,
                defense: 0,
                maxHp: 120,
                currentHp: 120,
                speed: 100,
                classType: .Mage,
                attackType: .Skip,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.hijiriByakurenProfileSmall,
                big: TouhouSiegeStyle.Images.hijiriByakurenProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.hijiriByakurenIdle,
                attack: TouhouSiegeStyle.Images.hijiriByakurenAttack,
                faint: TouhouSiegeStyle.Images.hijiriByakurenFaint,
                moveForward: TouhouSiegeStyle.Images.hijiriByakurenMoveForward,
                moveBackward: TouhouSiegeStyle.Images.hijiriByakurenMoveBackwards,
                getHit: TouhouSiegeStyle.Images.hijiriByakurenGetHit
                )
        ),
        
        GameCharacter(
            id: 104,
            name: "Koishi Komeiji",
            team: .enemy,
            stats: GameCharacter.Stats(
                attack: 24,
                defense: 10,
                maxHp: 200,
                currentHp: 200,
                speed: 60,
                classType: .Mage,
                attackType: .Back,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.koishiKomeijiProfileSmall,
                big: TouhouSiegeStyle.Images.koishiKomeijiProfileLarge),
            animations: GameCharacter.Animations(
                idle: TouhouSiegeStyle.Images.koishiKomeijiIdle,
                attack: TouhouSiegeStyle.Images.koishiKomeijiAttack,
                faint: TouhouSiegeStyle.Images.koishiKomeijiFaint,
                moveForward: TouhouSiegeStyle.Images.koishiKomeijiMoveForward,
                moveBackward: TouhouSiegeStyle.Images.koishiKomeijiMoveBackwards,
                getHit: TouhouSiegeStyle.Images.koishiKomeijiGetHit
                )
            ),
        
        GameCharacter(
            id: 105,
            name: "Reisen Udongein Inaba",
            team: .enemy,
            stats: GameCharacter.Stats(
                attack: 40,
                defense: 2,
                maxHp: 70,
                currentHp: 70,
                speed: 130,
                classType: .Mage,
                attackType: .Back,
                level: 1
            ),
            profilePicture: GameCharacter.ProfilePicture(
                small: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileSmall,
                big: TouhouSiegeStyle.Images.reisenUdongeinInabaProfileLarge),
            animations: GameCharacter.Animations(
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
