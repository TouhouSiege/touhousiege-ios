//
//  GameScene.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-02.
//

import SpriteKit
import SwiftUI

class GameScene: SKScene {
    /// In SpriteKit screen doesnt start at 0 it starts in the middle so this is needed to be able to make use of the whole width easier dynamically
    let middleScreen: CGFloat = UIScreen.main.bounds.width / 2
    let width: CGFloat = UIScreen.main.bounds.width
    
    var vm: GameViewModel?
    var user: User?
    var enemyUser: User?
    var isDefenseSetting: Bool?
    var isComputerPlaying: Bool?
    var checkForCharactersPlaced: CheckForCharactersPlaced?
    
    var enemyPlacementArrayPlayer: [GameCharacter?] = [] {
        didSet {
            vm?.randomEnemyDelayFunction()
        }
    }
    
    var placedCharacters: [String: SKSpriteNode] = [:] {
        didSet {
            if !placedCharacters.isEmpty {
                checkForCharactersPlaced?.isCharactersPlaced = true
            }
            
            if placedCharacters.isEmpty {
                checkForCharactersPlaced?.isCharactersPlaced = false
            }
        }
    }
    
    var disabledProfiles: [String: SKSpriteNode] = [:]
    var disabledProfilesStrings: [String] = []
    var profilePicturesCurrentlyShowing: [SKSpriteNode] = []
    var profilePicturesCurrentlyShowingPositions: [CGPoint] = []
    var profilePicturesTemporaryArrayOfIds: [Int] = []
    var enemyPositions: [Int: GameCharacter] = [:]
    var playerPlacementArray: [GameCharacter?] = Array(repeating: nil, count: 15)
    
    var leftArrow: SKSpriteNode?
    var rightArrow: SKSpriteNode?
    
    override func update(_ currentTime: TimeInterval) {
        guard let vm = vm else { return }
        
        if vm.observableBoolGameStatus {
            self.removeAllActions()
        }
    }
    
    override func didMove(to view: SKView) {
        guard let vm = vm else { return }
        
        vm.gameScene = self
        
        print("GameScene Loaded!")
        guard let user = user else { return print("No characters found!") }
        guard let isDefenseSetting = isDefenseSetting else { return }
  
        for profilePicture in user.characters {
            guard let profilePicture = profilePicture.id else { return }
            profilePicturesTemporaryArrayOfIds.append(profilePicture)
        }
        
        if isDefenseSetting {
            createArrowButtons()
            createHexagonPlatforms()
            createCharacterProfileSelection(characterIds: profilePicturesTemporaryArrayOfIds)
            
            /* TODO - need to map out all characters in corresponding dictionairys and check for profile aswell.
            if !user.defense.isEmpty {
                placePlayerCharacters(playerDefense: user.defense)
             
                TODO - MIRROR
            }
             */
            
        } else {
            createArrowButtons()
            createHexagonPlatforms()
            createEnemyHexagonPlatforms()
            createCharacterProfileSelection(characterIds: profilePicturesTemporaryArrayOfIds)
  
            
            guard let isComputerPlaying = isComputerPlaying else { return }
            
            if !isComputerPlaying {
                guard let enemyDefense = enemyUser?.defense else { return }
                
                for character in enemyDefense {
                    print("Character name: \(String(describing: character?.name)) + Character ID: \(String(describing: character?.id))")
                }
                
                placeEnemyCharacters(enemyArray: enemyDefense)
            }
            
            if isComputerPlaying {
                placeEnemyCharacters(enemyArray: vm.enemyPlacementArrayComputer)
            } 
        }
    }
    
    var currentSelectedCharacter: SKSpriteNode?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            /// Check for existing character on hexagon
            if let selectedNode = nodes.first(where: { placedCharacters[$0.name ?? ""] != nil }) {
                currentSelectedCharacter = selectedNode as? SKSpriteNode
                return
            }
            
            /// Check if profile picture was tapped and gets the corresponding character for it
            if let selectedNode = nodes.first(where: { node in node.name?.starts(with: "profile_") == true }) {
                let realCharacterName = selectedNode.name!.replacingOccurrences(of: "profile_", with: "")
                
                /// Creates a new sprite for the first click on profile
                if let characterData = user?.characters.first(where: { $0.name == realCharacterName }) {
                    let newCharacterSpriteBase = SKSpriteNode(imageNamed: characterData.animations.idle[0])
                    newCharacterSpriteBase.position = location
                    
                    /// Calculates width depending on height - Did this becuase I messed up with some pixel cutting of sprites so was easier to not redo everything
                    if let texture = newCharacterSpriteBase.texture {
                        newCharacterSpriteBase.size = CGSize(width: (width * TouhouSiegeStyle.Decimals.xxLarge) * (texture.size().width / texture.size().height), height: width * TouhouSiegeStyle.Decimals.xxLarge)
                    } else {
                        newCharacterSpriteBase.size = CGSize(width: width * TouhouSiegeStyle.Decimals.xxLarge, height: width * TouhouSiegeStyle.Decimals.xxLarge)
                    }
                    
                    newCharacterSpriteBase.name = realCharacterName
                    
                    self.addChild(newCharacterSpriteBase)
                    
                    currentSelectedCharacter = newCharacterSpriteBase
                    disableCharacterProfileSelection(characterName: realCharacterName)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let character = currentSelectedCharacter {
            for touch in touches {
                character.position = touch.location(in: self)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            if nodes.first(where: { $0.name == "rightArrow"}) != nil {
                leftAndRightArrowFunctionality(arrow: "rightArrow")
                return
            }
            
            if nodes.first(where: { $0.name == "leftArrow"}) != nil {
                leftAndRightArrowFunctionality(arrow: "leftArrow")
                return
            }
            
            guard let vm = vm else { return }
            let areaToPlacePlayerCharacter = self.children.filter { $0.name == "areatoplacecharacter" }
            
            if let character = currentSelectedCharacter {
                for touch in touches {
                    let location = touch.location(in: self)
                    
                    if let validAreaToPlaceCharacter = areaToPlacePlayerCharacter.first(where: { ($0 as? SKSpriteNode)?.contains(location) ?? false }) {
                        
                        character.position = CGPoint(x: validAreaToPlaceCharacter.position.x, y: validAreaToPlaceCharacter.position.y + (width * TouhouSiegeStyle.Decimals.medium))
                        
                        guard let placedCharacterName = character.name else { return }
                        
                        if let placedCharacterData = user?.characters.first(where: { $0.name == placedCharacterName }),
                           let placedCharacterIndex = areaToPlacePlayerCharacter.firstIndex(of: validAreaToPlaceCharacter) {
                            let previousIndex = playerPlacementArray.firstIndex(where: { $0?.id == placedCharacterData.id })
                            
                            /// Makes sure if a placed character sprite is moved the index in the array gets removed so no duplicates are made
                            if previousIndex != nil && previousIndex != placedCharacterIndex {
                                guard let previousIndex else { return }
                                
                                playerPlacementArray[previousIndex] = nil
                            }
                            
                            /// Removes sprite and re enables picking of that character if a sprite was already placed
                            if playerPlacementArray[placedCharacterIndex] != nil {
                                _ = playerPlacementArray[placedCharacterIndex]
                                if let replacedCharacter = playerPlacementArray[placedCharacterIndex] {
                                    let replacedCharacterId = replacedCharacter.id
                                    if let replacedCharacterName = user?.characters.first(where: { $0.id == replacedCharacterId })?.name,
                                       let replacedSprite = placedCharacters[replacedCharacterName] {
                                        placedCharacters.removeValue(forKey: replacedCharacterName)
                                        replacedSprite.removeFromParent()
                                        reEnableCharacterProfileSelection(characterName: replacedCharacterName)
                                    }
                                    playerPlacementArray[placedCharacterIndex] = nil
                                }
                            }
                            
                            /// Add placed character to the board and saves id, character and index
                            playerPlacementArray[placedCharacterIndex] = placedCharacterData
                            placedCharacters[placedCharacterName] = character
                            vm.playerSpritesHexaCoord[placedCharacterIndex] = character
                        }
                        
                        startIdleAnimation(character: character, characterName: character.name ?? "")
                        disableCharacterProfileSelection(characterName: character.name ?? "")
                        
                    } else {
                        /// If dragged outside valid position, resets character
                        if let characterId = user?.characters.first(where: { $0.name == character.name })?.id {
                            if let index = playerPlacementArray.firstIndex(where: { $0?.id == characterId }) {
                                playerPlacementArray[index] = nil
                            }
                        }
                        
                        placedCharacters.removeValue(forKey: character.name ?? "")
                        character.removeFromParent()
                        reEnableCharacterProfileSelection(characterName: character.name ?? "")
                    }
                }
                
                currentSelectedCharacter = nil
            }
        }
    }
    
    /// Mini profiles to drag out the sprites from
    func createCharacterProfileSelection(characterIds: [Int]) {
        let smallProfileSize: CGFloat = width * TouhouSiegeStyle.Decimals.large
        let spacing: CGFloat = width * TouhouSiegeStyle.Decimals.xxSmall
        let startX: CGFloat = (width * TouhouSiegeStyle.Decimals.large) + (width * TouhouSiegeStyle.Decimals.xxSmall)
        var spacingDecider: CGFloat = 1
        
        for (index, characterId) in characterIds.enumerated() {
            if index == (profilePicturesTemporaryArrayOfIds.startIndex) || index == ((profilePicturesTemporaryArrayOfIds.startIndex + 1)) || index == (profilePicturesTemporaryArrayOfIds.endIndex - 1) || index == (profilePicturesTemporaryArrayOfIds.endIndex - 2) || index == (profilePicturesTemporaryArrayOfIds.endIndex - 3) {
                if let characterData = user?.characters.first(where: { $0.id == characterId }) {
                    let icon = SKSpriteNode(imageNamed: characterData.profilePicture.small)
                    icon.position = CGPoint(x: startX + (CGFloat(spacingDecider) * (smallProfileSize + spacing)), y: spacing * 6)
                    icon.size = CGSize(width: smallProfileSize, height: smallProfileSize)
                    icon.name = "profile_" + characterData.name
                    
                    spacingDecider += 1
                    profilePicturesCurrentlyShowing.append(icon)
                    profilePicturesCurrentlyShowingPositions.append(icon.position)
                    
                    self.addChild(icon)
                }
            }
        }
    }
    
    /// Disables profile pics if character has been placed and track it
    func disableCharacterProfileSelection(characterName: String) {
        let name: String = "profile_" + characterName
        
        if let icon = self.children.first(where: { $0.name == name }) as? SKSpriteNode {
            icon.color = UIColor.black
            icon.colorBlendFactor = TouhouSiegeStyle.BigDecimals.xLarge
            icon.name = nil
            
            disabledProfiles[characterName] = icon
            disabledProfilesStrings.append(characterName)
        }
    }
    
    /// Enables profile again if characters profile is in the disabledProfiles array
    func reEnableCharacterProfileSelection(characterName: String) {
        if let icon = disabledProfiles[characterName] {
            icon.colorBlendFactor = 0
            icon.name = "profile_" + characterName
            
            disabledProfiles.removeValue(forKey: characterName)
            disabledProfilesStrings.removeAll { $0 == characterName }
            
        }
        
    }
    
    /// Creates left and right arrow buttons that allow the user to move between pages.
    func createArrowButtons() {
        leftArrow = SKSpriteNode(imageNamed: "leftarrow")
        leftArrow?.name = "leftArrow"
        leftArrow?.size = CGSize(width: width * TouhouSiegeStyle.Decimals.medium, height: width * TouhouSiegeStyle.Decimals.medium)
        leftArrow?.position = CGPoint(x: width * TouhouSiegeStyle.Decimals.large, y: width * TouhouSiegeStyle.Decimals.large)
        addChild(leftArrow!)
        
        rightArrow = SKSpriteNode(imageNamed: "rightarrow")
        rightArrow?.name = "rightArrow"
        rightArrow?.size = CGSize(width: width * TouhouSiegeStyle.Decimals.medium, height: width * TouhouSiegeStyle.Decimals.medium)
        rightArrow?.position = CGPoint(x: ((width * TouhouSiegeStyle.Decimals.large) * 7.1) + ((width * TouhouSiegeStyle.Decimals.xxSmall) * 7), y: width * TouhouSiegeStyle.Decimals.large)
        addChild(rightArrow!)
        
    }
    
    /// Function for the arrows for character selection
    func leftAndRightArrowFunctionality(arrow: String) {
        if arrow == "leftArrow" {
            /// Remove the profile picture at the furthest right
            profilePicturesCurrentlyShowing[profilePicturesCurrentlyShowing.count - 1].removeFromParent()
            profilePicturesCurrentlyShowing.remove(at: profilePicturesCurrentlyShowing.count - 1)
            
            /// Move up the 2 icons left to the right one step to look like selecting left
            profilePicturesCurrentlyShowing[0].position = profilePicturesCurrentlyShowingPositions[1]
            profilePicturesCurrentlyShowing[1].position = profilePicturesCurrentlyShowingPositions[2]
            profilePicturesCurrentlyShowing[2].position = profilePicturesCurrentlyShowingPositions[3]
            profilePicturesCurrentlyShowing[3].position = profilePicturesCurrentlyShowingPositions[4]
            
            let characterId = profilePicturesTemporaryArrayOfIds[(profilePicturesTemporaryArrayOfIds.count / 2) - 1]
            
            if let characterData = user?.characters.first(where: { $0.id == characterId }) {
                let icon = SKSpriteNode(imageNamed: characterData.profilePicture.small)
                icon.position = profilePicturesCurrentlyShowingPositions[0]
                icon.size = profilePicturesCurrentlyShowing[1].size
                
                var isProfileDisabled = false
                
                for name in disabledProfilesStrings {
                    if name == characterData.name {
                        icon.color = UIColor.black
                        icon.colorBlendFactor = TouhouSiegeStyle.BigDecimals.xLarge
                        icon.name = nil
                        isProfileDisabled = true
                    }
                }
                
                if !isProfileDisabled {
                    icon.name = "profile_" + characterData.name
                }
                
                profilePicturesCurrentlyShowing.insert(icon, at: 0)
                
                let characterIdToBeMoved = profilePicturesTemporaryArrayOfIds[profilePicturesTemporaryArrayOfIds.count - 1]
                
                profilePicturesTemporaryArrayOfIds.remove(at: profilePicturesTemporaryArrayOfIds.count - 1)
                profilePicturesTemporaryArrayOfIds.insert(characterIdToBeMoved, at: 0)
                
                self.addChild(icon)
            }
        }
        
        if arrow == "rightArrow" {
            /// Remove the profile picture at the furthest right
            profilePicturesCurrentlyShowing[profilePicturesCurrentlyShowing.startIndex].removeFromParent()
            profilePicturesCurrentlyShowing.remove(at: profilePicturesCurrentlyShowing.startIndex)
            
            /// Move up the 2 icons left to the right one step to look like selecting left
            profilePicturesCurrentlyShowing[0].position = profilePicturesCurrentlyShowingPositions[0]
            profilePicturesCurrentlyShowing[1].position = profilePicturesCurrentlyShowingPositions[1]
            profilePicturesCurrentlyShowing[2].position = profilePicturesCurrentlyShowingPositions[2]
            profilePicturesCurrentlyShowing[3].position = profilePicturesCurrentlyShowingPositions[3]
            
            let characterId = profilePicturesTemporaryArrayOfIds[(profilePicturesTemporaryArrayOfIds.count / 2) - 1]
            
            if let characterData = user?.characters.first(where: { $0.id == characterId }) {
                let icon = SKSpriteNode(imageNamed: characterData.profilePicture.small)
                icon.position = profilePicturesCurrentlyShowingPositions[4]
                icon.size = profilePicturesCurrentlyShowing[1].size
                
                var isProfileDisabled = false
                
                for name in disabledProfilesStrings {
                    if name == characterData.name {
                        icon.color = UIColor.black
                        icon.colorBlendFactor = TouhouSiegeStyle.BigDecimals.xLarge
                        icon.name = nil
                        isProfileDisabled = true
                    }
                }
                
                if !isProfileDisabled {
                    icon.name = "profile_" + characterData.name
                }
                
                profilePicturesCurrentlyShowing.insert(icon, at: 4)
                
                let characterIdToBeMoved = profilePicturesTemporaryArrayOfIds[profilePicturesTemporaryArrayOfIds.startIndex]
                
                profilePicturesTemporaryArrayOfIds.remove(at: profilePicturesTemporaryArrayOfIds.startIndex)
                profilePicturesTemporaryArrayOfIds.insert(characterIdToBeMoved, at: profilePicturesTemporaryArrayOfIds.endIndex)
                
                self.addChild(icon)
            }
        }
    }
    
    /// Start the idle animation of a character and loops it
    func startIdleAnimation(character: SKSpriteNode, characterName: String) {
        var textures: [SKTexture] = []
        
        if let characterData = user?.characters.first(where: { $0.name == characterName }) {
            for imageName in characterData.animations.idle {
                textures.append(SKTexture(imageNamed: imageName))
            }
        }
        
        let repeatAnimationIdle = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: TouhouSiegeStyle.BigDecimals.xxSmall))
        
        character.run(repeatAnimationIdle)
    }
    
    /// Creates the player side hexagon platforms
    func createHexagonPlatforms() {
        guard let vm = vm else { return }
        guard let isDefenseSetting = isDefenseSetting else { return }
        
        let hexagonSize = CGSize(width: width * TouhouSiegeStyle.Decimals.xMedium, height: width * TouhouSiegeStyle.Decimals.xMedium)
        let hexagonSpaceBetweenX: CGFloat = hexagonSize.width * 1.1
        let hexagonSpaceBetweenY: CGFloat = hexagonSize.height * 1.1
        //let hexagonStartX: CGFloat = width * (TouhouSiegeStyle.BigDecimals.xxSmall + TouhouSiegeStyle.Decimals.xMedium)
        let hexagonStartX: CGFloat = {
            if isDefenseSetting {
                return ((width / 2) - (hexagonSpaceBetweenX * 3))
            } else {
                return width * (TouhouSiegeStyle.BigDecimals.xxSmall + TouhouSiegeStyle.Decimals.xMedium)
            }
        }()
        
        let hexagonStartY: CGFloat = width * TouhouSiegeStyle.BigDecimals.small
        
        let columns = 5
        let rows = 3
        let rowOffset: CGFloat = hexagonSpaceBetweenX / -3
        
        var currentStartX = hexagonStartX
        
        for row in 0..<rows {
            if row > 0 {
                currentStartX += rowOffset
            }
            
            for col in 0..<columns {
                let posX = currentStartX + CGFloat(col) * hexagonSpaceBetweenX
                let posY = hexagonStartY - CGFloat(row) * hexagonSpaceBetweenY
                
                let hexagon = SKSpriteNode(imageNamed: "hexagonplatform")
                hexagon.size = hexagonSize
                hexagon.xScale = -1
                hexagon.position = CGPoint(x: posX, y: posY)
                hexagon.name = "hexagonPlatform"
                vm.playerHexagonCoordinates.append(hexagon.position)
                
                let areaToPlaceCharacter = SKSpriteNode(color: UIColor.systemPink, size: CGSize(width: hexagonSize.width, height: hexagonSize.height))
                areaToPlaceCharacter.position = hexagon.position
                areaToPlaceCharacter.alpha = 0
                areaToPlaceCharacter.name = "areatoplacecharacter"
                
                self.addChild(hexagon)
                self.addChild(areaToPlaceCharacter)
            }
        }
    }
    
    /// Creates the enemy side hexagon platforms
    func createEnemyHexagonPlatforms() {
        guard let vm = vm else { return }
        let hexagonSize = CGSize(width: width * TouhouSiegeStyle.Decimals.xMedium, height: width * TouhouSiegeStyle.Decimals.xMedium)
        let hexagonSpaceBetweenX: CGFloat = hexagonSize.width * 1.1
        let hexagonSpaceBetweenY: CGFloat = hexagonSize.height * 1.1
        let hexagonStartX: CGFloat = -width * 0.5
        let hexagonStartY: CGFloat =  width * TouhouSiegeStyle.BigDecimals.small
        
        let columns = 5
        let rows = 3
        let rowOffset: CGFloat = hexagonSpaceBetweenX / -3
        
        var currentStartX = hexagonStartX
        
        for row in 0..<rows {
            if row > 0 {
                currentStartX += rowOffset
            }
            
            for col in 0..<columns {
                let posX = currentStartX - CGFloat(col) * hexagonSpaceBetweenX
                let posY = hexagonStartY - CGFloat(row) * hexagonSpaceBetweenY
                
                let hexagon = SKSpriteNode(imageNamed: "hexagonplatform")
                hexagon.size = hexagonSize
                hexagon.position = CGPoint(x: -posX, y: posY)
                hexagon.name = "enemyHexagonPlatform"
                vm.enemyHexagonCoordinates.append(hexagon.position)
                
                let interactionArea = SKSpriteNode(color: UIColor.systemPink, size: CGSize(width: hexagonSize.width, height: hexagonSize.height))
                interactionArea.position = hexagon.position
                interactionArea.alpha = 0
                
                self.addChild(hexagon)
                self.addChild(interactionArea)
            }
        }
    }
    
    /// Places enemy characters based on an aray of character ids TODO - enemyUSER should not search here.
    func placeEnemyCharacters(enemyArray: [GameCharacter?]) {
        guard let vm = vm else { return }
        
        let enemyHexagons = self.children.filter { $0.name == "enemyHexagonPlatform" }
        
        for (index, character) in enemyArray.enumerated() {
            if let enemyCharacter = character,
               let characterData = Characters.allCharacters.first(where: { $0.name == enemyCharacter.name }) {
                
                guard index < enemyHexagons.count else { continue }
                
                /// To mirror the placement of characters
                let indexMirror = enemyHexagons.count - 1 - index
                guard indexMirror < enemyHexagons.count else { continue }
                
                let enemySprite = SKSpriteNode(imageNamed: characterData.animations.idle[0])
                
                if let texture = enemySprite.texture {
                    let aspectRatio = texture.size().width / texture.size().height
                    enemySprite.size = CGSize(width: (width * TouhouSiegeStyle.Decimals.xxLarge) * aspectRatio, height: width * TouhouSiegeStyle.Decimals.xxLarge)
                }
                
                enemySprite.name = characterData.name
                enemySprite.xScale = -1   /// Mirror it
                
                let hexagonPosition = CGPoint(x: enemyHexagons[indexMirror].frame.midX, y: enemyHexagons[indexMirror].frame.midY + (width * TouhouSiegeStyle.Decimals.medium))
                enemySprite.position = hexagonPosition
                vm.enemyHexagonCoordinates.append(hexagonPosition)
                vm.enemySpritesHexaCoord[index] = enemySprite
                startIdleAnimation(character: enemySprite, characterName: characterData.name)
                self.addChild(enemySprite)
            }
        }
    }

    /// TODO
    /// Places player characters based on an aray of character ids if in defense mode
    func placePlayerCharacters(playerDefense: [Int]) {
        guard let vm = vm else { return }
        
        let playerHexagons = self.children.filter { $0.name == "hexagonPlatform" }
        
        for (index, characterId) in playerDefense.enumerated() {
            
            if let characterData = user?.characters.first(where: { $0.id == characterId }) {
                let playerSprite = SKSpriteNode(imageNamed: characterData.animations.idle[0])
                
                if let texture = playerSprite.texture {
                    let aspectRatio = texture.size().width / texture.size().height
                    playerSprite.size = CGSize(width: (width * TouhouSiegeStyle.Decimals.xxLarge) * aspectRatio, height: width * TouhouSiegeStyle.Decimals.xxLarge)
                }
                
                playerSprite.name = characterData.name
                
                let hexagonPosition = CGPoint(x: playerHexagons[index].frame.midX, y: playerHexagons[index].frame.midY + (width * TouhouSiegeStyle.Decimals.medium))
                playerSprite.position = hexagonPosition
                vm.playerHexagonCoordinates.append(hexagonPosition)
                vm.playerSpritesHexaCoord[index] = playerSprite
                startIdleAnimation(character: playerSprite, characterName: characterData.name)
                
                self.addChild(playerSprite)
            }
        }
    }
}
