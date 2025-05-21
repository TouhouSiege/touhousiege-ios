//
//  ApiDtoConversions.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-21.
//

import Foundation

extension GameCharacter {
    func toCharacterData() -> CharacterData {
        return CharacterData(
            name: self.name,
            team: self.team.rawValue,
            stats: self.stats.toStatsData(),
            profilePicture: self.profilePicture.toProfilePictureData(),
            animations: self.animations.toAnimationsData()
        )
    }
}

extension GameCharacter.Stats {
    func toStatsData() -> StatsData {
        return StatsData(
            attack: self.attack,
            defense: self.defense,
            maxHp: self.maxHp,
            currentHp: self.currentHp,
            speed: self.speed,
            classType: self.classType.rawValue,
            attackType: self.attackType.rawValue
        )
    }
}

extension GameCharacter.ProfilePicture {
    func toProfilePictureData() -> ProfilePictureData {
        return ProfilePictureData(
            small: self.small,
            big: self.big
        )
    }
}

extension GameCharacter.Animations {
    func toAnimationsData() -> AnimationsData {
        return AnimationsData(
            idle: self.idle,
            attack: self.attack,
            faint: self.faint,
            moveForward: self.moveForward,
            moveBackward: self.moveBackward,
            getHit: self.getHit
        )
    }
}

