//
//  GameViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import Foundation
import SpriteKit

class GameViewModel {
    weak var gameScene: GameScene?
    
    let width = UIScreen.main.bounds.width
    
    var playerHexagonCoordinates: [CGPoint] = []
    var enemyHexagonCoordinates: [CGPoint] = []
    
    var playerSpritesHexaCoord: [SKSpriteNode?] = Array(repeating: nil, count: 15)
    var enemySpritesHexaCoord: [SKSpriteNode?] =  Array(repeating: nil, count: 15)
    
    var turnQueueArray: [CharacterOnBoard] = []
    var turnQueueIndexOfWhosTurn = 0
    var roundNumber: Int = 0
    
    /// Arrays for player vs computer
    var enemyPlacementArray: [Int] = {
        let randomArrayNumber = Int.random(in: 0...3)
        
        switch randomArrayNumber {
        case 0: return [101, 0, 0, 0, 102, 103, 0, 0, 0, 0, 0, 104, 0, 105]
        case 1: return [0, 103, 102, 0, 0, 101, 0, 0, 104, 0, 0, 105, 0, 0]
        case 2: return [105, 0, 0, 103, 0, 0, 0, 102, 0, 104, 0, 101, 0, 0]
        case 3: return [0, 0, 101, 0, 102, 0, 0, 105, 0, 0, 103, 0, 0, 104]
        default: return []
        }
    }()
    
    var playerWon: Bool = false
    var enemyWon: Bool = false
    var isGameOver: Bool = false {
        didSet {
            if playerWon {
                winner(enemyWon: false)
            }
            
            if enemyWon {
                winner(enemyWon: true)
            }
        }
    }
    
    var observableBoolGameStatus: Bool = false
    
    /// Generates a random background for the gamescene
    func randomBackgroundGenerator() -> String {
        let randomBackground = Int.random(in: 0...7)
        
        return TouhouSiegeStyle.Images.bg_play[randomBackground]
    }
    
    func startGame() {
        print("**********GAME STARTED!**********")

        removeProfilesPicturesAndArrows()
        resetTurnQueue()
    }
    
    /// Removes the profiles selection, arrows and buttons as soon as the game starts
    func removeProfilesPicturesAndArrows() {
        guard let gameScene = gameScene else { return }
        
        for profile in gameScene.profilePicturesCurrentlyShowing {
            profile.removeFromParent()
        }
        
        gameScene.leftArrow?.removeFromParent()
        gameScene.rightArrow?.removeFromParent()
    }
    
    /// Reset the queue of turns for the characters and rearranges the order based on speed
    func resetTurnQueue() {
        guard let gameScene = gameScene else { return }
        
        checkForWinner()

        if isGameOver { return }
        
        roundNumber += 1
        var characterTurnQueue: [CharacterOnBoard] = []
        
        /// Adds player characters to the queue
        for index in 0..<gameScene.playerPlacementArray.count {
            if gameScene.playerPlacementArray[index] != 0, let character = getPlayerCharacter(hexIndex: index) {
                characterTurnQueue.append(CharacterOnBoard(character: character, isEnemy: false))
            }
        }
        
        /// Adds enemy characters to the queue
        for index in 0..<enemyPlacementArray.count {
            if enemyPlacementArray[index] != 0, let character = getEnemyCharacter(hexIndex: index) {
                characterTurnQueue.append(CharacterOnBoard(character: character, isEnemy: true))
            }
        }
        
        /// Sorts by character speed (base speed from character class for now)
        characterTurnQueue.sort { $0.character.stats.speed > $1.character.stats.speed }
        
        turnQueueArray = characterTurnQueue
        turnQueueIndexOfWhosTurn = 0
        characterPreTurnProcess()
    }
    
    /// The turn and process of each characters turn
    func characterPreTurnProcess() {
        checkForWinner()
        
        if isGameOver { return }
        
        /// Checks so the turnQueue isn't empty and calls the resets function if it is
        if turnQueueIndexOfWhosTurn >= turnQueueArray.count {
            resetTurnQueue()
            return
        }
        
        /// Checks if a character has fainted during the round and skips if that characters turn comes up
        if turnQueueArray[turnQueueIndexOfWhosTurn].character.stats.hp <= 0 {
            turnQueueIndexOfWhosTurn += 1
            characterPreTurnProcess()
            return
        }
        
        let characterToAct = turnQueueArray[turnQueueIndexOfWhosTurn]
        
        if characterToAct.isEnemy {
            enemyCharacterTurnProcess(characterOnBoard: characterToAct)
        } else {
            playerCharacterTurnProcess(characterOnBoard: characterToAct)
        }
    }
    
    /// Players turn
    func playerCharacterTurnProcess(characterOnBoard: CharacterOnBoard) {
        let characterToAct = characterOnBoard.character
        
        guard let characterToActIndex = getPlayerHexagonIndex(characterId: characterToAct.id) else { return }
        guard let characterToActSprite = playerSpritesHexaCoord[characterToActIndex] else { return }
        guard let characterToAttackIndex = selectTargetIndex(attackerFormationIndex: characterToActIndex,opposingFormation: enemyPlacementArray,attackType: characterToAct.stats.attackType, isTargetEnemy: true) else { return }
        guard let characterToAttackSprite = enemySpritesHexaCoord[characterToAttackIndex] else { return }
   
        attackAnimationsAndOutcome(characterToActSprite: characterToActSprite, characterToAttackSprite: characterToAttackSprite, isTargetEnemy: true) {
            self.turnQueueIndexOfWhosTurn += 1
            self.characterPreTurnProcess()
        }
    }
    
    /// Enemy turn
    private func enemyCharacterTurnProcess(characterOnBoard: CharacterOnBoard) {
        let characterToAct = characterOnBoard.character
        
        guard let gameScene = gameScene else { return }
        guard let characterToActIndex = getEnemyHexagonIndex(characterID: characterToAct.id) else { return }
        guard let characterToActSprite = enemySpritesHexaCoord[characterToActIndex] else { return }
        guard let characterToAttackIndex = selectTargetIndex(attackerFormationIndex: characterToActIndex, opposingFormation: gameScene.playerPlacementArray, attackType: characterToAct.stats.attackType, isTargetEnemy: false) else { return }
        guard let characterToAttackSprite = playerSpritesHexaCoord[characterToAttackIndex] else { return }

        attackAnimationsAndOutcome(characterToActSprite: characterToActSprite, characterToAttackSprite: characterToAttackSprite, isTargetEnemy: false) {
            self.turnQueueIndexOfWhosTurn += 1
            self.characterPreTurnProcess()
        }
    }
    
    /// Checks if a winner is present and if it is, removes everyone from the queue and ends the game
    func checkForWinner() {
        guard let gameScene = gameScene else { return }
        
        let isEnemyAlive = enemyPlacementArray.contains { $0 != 0 }
        let isPlayerAlive = gameScene.playerPlacementArray.contains { $0 != 0 }
        
        if !isEnemyAlive {
            turnQueueArray.removeAll()
            playerWon = true
            isGameOver = true
        } else if !isPlayerAlive {
            turnQueueArray.removeAll()
            enemyWon = true
            isGameOver = true
        }
    }
    
    /// Gets called when a winner is found TODO - IMPLEMENT AFTER STUFF
    func winner(enemyWon: Bool) {
        if enemyWon {
            print("haha du förlorade")
        }
        
        if playerWon {
            print("grattis du vann!")
        }

        observableBoolGameStatus = true
    }
    
    func attackAnimationsAndOutcome(characterToActSprite: SKSpriteNode, characterToAttackSprite: SKSpriteNode, isTargetEnemy: Bool, completion: @escaping () -> Void) {
        characterToActSprite.removeAllActions() /// To remove the idle animation
        
        let characterToActOriginalZPosition = characterToActSprite.zPosition
        characterToActSprite.zPosition = 777
        
        if let texture = characterToActSprite.texture {
            let aspectRatio = texture.size().width / texture.size().height
            characterToActSprite.size = CGSize(width:  (width * TouhouSiegeStyle.Decimals.xxLarge) * aspectRatio, height: width * TouhouSiegeStyle.Decimals.xxLarge)
        }
        
        guard let characterToActName = characterToActSprite.name?.replacingOccurrences(of: "enemy_", with: "") else { return }
        guard let characterToAttackName = characterToAttackSprite.name?.replacingOccurrences(of: "enemy_", with: "") else { return }
        guard let attackerData = Characters.allCharacters.first(where: { $0.name == characterToActName }) else { return }
        
        let characterToAttackTeamCheck: Character.Team = isTargetEnemy ? .enemy : .player
        
        guard let characterToAttackData = Characters.allCharacters.first(where: { $0.name == characterToAttackName && $0.team == characterToAttackTeamCheck }) else { return }
        
        /// Positions of attacker and defender
        let characterToActOrginialPosition = characterToActSprite.position
        let characterToAttackPosition = characterToAttackSprite.position
        
        let distanceXAxis = characterToAttackPosition.x - characterToActOrginialPosition.x
        let distanceYAxis = characterToAttackPosition.y - characterToActOrginialPosition.y
        
        let distanceToTarget = sqrt(distanceXAxis * distanceXAxis + distanceYAxis * distanceYAxis)
 
        /// To make the attacker hit the defender slightly about infront instead of inside the center aswell
        let adjustedTargetPosition = CGPoint(
            x: characterToAttackPosition.x - distanceXAxis / distanceToTarget * width * TouhouSiegeStyle.Decimals.xSmall,
            y: characterToAttackPosition.y - distanceYAxis / distanceToTarget * (width * TouhouSiegeStyle.Decimals.xSmall) + (width * TouhouSiegeStyle.Decimals.xSmall)
        )
        
        /// Part 1 of animation - Moving forward
        let characterToActForwardTextures = attackerData.animations.moveForward.map { SKTexture(imageNamed: $0) }
        let partOneDuration = TouhouSiegeStyle.BigDecimals.xxLarge
        let characterToActMoveForward = SKAction.move(to: adjustedTargetPosition, duration: partOneDuration)
        let characterToActForwardAnimation = SKAction.animate(with: characterToActForwardTextures, timePerFrame: partOneDuration / Double(characterToActForwardTextures.count))
        
        let partOne = SKAction.sequence([SKAction.group([
            characterToActMoveForward,
            characterToActForwardAnimation
        ])])
        
        /// Part 2 of animation - Attacking and Damage calculation
        let characterToActAttackTextures = attackerData.animations.attack.map { SKTexture(imageNamed: $0) }
        let partTwoDuration = TouhouSiegeStyle.BigDecimals.xLarge
        let characterToActAttackAnimation = SKAction.animate(with: characterToActAttackTextures, timePerFrame: partTwoDuration / Double(characterToActAttackTextures.count))
        
        let characterToAttackGetHitTextures = characterToAttackData.animations.getHit.map { SKTexture(imageNamed: $0) }
        let characterToAttackGetHitAnimation = SKAction.animate(with: characterToAttackGetHitTextures, timePerFrame: partTwoDuration / Double(characterToAttackGetHitTextures.count))
        let characterToAttackGetHitRunAnimation = SKAction.run { characterToAttackSprite.run(characterToAttackGetHitAnimation) }
        
        let damageOutComeAction = SKAction.run { self.calculateAndApplyDamage(from: attackerData, to: characterToAttackData, targetSprite: characterToAttackSprite, isTargetEnemy: isTargetEnemy) }
        
        let partTwo = SKAction.sequence([SKAction.group([
            characterToActAttackAnimation,
            characterToAttackGetHitRunAnimation,
            damageOutComeAction
            ])])
        
        /// Part 3 of animation - Moving back and resuming idle animations
        let characterToActBackwardTextures = attackerData.animations.moveBackward.map { SKTexture(imageNamed: $0) }
        let partThreeDuration = TouhouSiegeStyle.BigDecimals.xxLarge
        let characterToActMoveBackwards = SKAction.move(to: characterToActOrginialPosition, duration: partThreeDuration)
        let characterToActBackwardsAnimation = SKAction.animate(with: characterToActBackwardTextures, timePerFrame: partThreeDuration / Double(characterToActBackwardTextures.count))
        
        let characterToAttackFaintTextures = characterToAttackData.animations.faint.map { SKTexture(imageNamed: $0) }
        let characterToAttackFaintAnimation = SKAction.animate(with: characterToAttackFaintTextures, timePerFrame: partThreeDuration / Double(characterToAttackFaintTextures.count))
        
        let characterToAttackFaintOrIdleAction = SKAction.run {
            if characterToAttackData.stats.hp <= 0 {
                characterToAttackSprite.run(characterToAttackFaintAnimation)
            } else {
                self.gameScene?.startIdleAnimation(character: characterToAttackSprite, characterName: characterToAttackName)
            }
        }
        
        let characterToAttackRemovalAction = SKAction.run {
            if characterToAttackData.stats.hp <= 0 {
                self.removeFaintedCharacterVisual(characterToAttackData, targetSprite: characterToAttackSprite)
            }
        }
        
        let partThree = SKAction.sequence([
            SKAction.group([
                characterToActMoveBackwards,
                characterToActBackwardsAnimation,
                characterToAttackFaintOrIdleAction
            ]),
            characterToAttackRemovalAction
        ])
        
        let characterToActResumeIdleAnimationAction = SKAction.run {
            characterToActSprite.zPosition = characterToActOriginalZPosition
            self.gameScene?.startIdleAnimation(character: characterToActSprite, characterName: characterToActName)
            completion()
        }
        
        /// Combining and playing all squences of events
        let allPartsCombined = SKAction.sequence([
            partOne,
            partTwo,
            partThree,
            characterToActResumeIdleAnimationAction
        ])
        
        characterToActSprite.run(allPartsCombined)
    }

    
    func calculateAndApplyDamage(from attacker: Character, to target: Character, targetSprite: SKSpriteNode, isTargetEnemy: Bool) {
        let calculatedDamage = attacker.stats.attack - target.stats.defense
        
        guard calculatedDamage > 0 else { return print("You did nothing!") }
        
        target.stats.hp -= calculatedDamage
        
        print("\(isTargetEnemy ? "Player" : "Enemy") \(attacker.name) deals \(calculatedDamage) damage to \(isTargetEnemy ? "Enemy" : "Player") \(target.name)! Remaining HP: \(target.stats.hp)")

        
        if target.stats.hp <= 0 {
            print("\(isTargetEnemy ? "Enemy" : "Player") \(target.name) has fainted!")
            removeFaintedCharacterLogical(target, isTargetEnemy: isTargetEnemy)
        }
    }
    
    /// Remove all logical information if a character faints so the game won't freeze
    func removeFaintedCharacterLogical(_ target: Character, isTargetEnemy: Bool) {
        guard let gameScene = gameScene else { return }
        
        if isTargetEnemy {
            for i in 0..<enemyPlacementArray.count {
                if enemyPlacementArray[i] == target.id {
                    enemyPlacementArray[i] = 0
                    break
                }
            }
        } else {
            for i in 0..<gameScene.playerPlacementArray.count {
                if gameScene.playerPlacementArray[i] == target.id {
                    gameScene.playerPlacementArray[i] = 0
                    break
                }
            }
        }
    }
    
    /// Removes a character sprite that has fainted after a turn
    func removeFaintedCharacterVisual(_ target: Character, targetSprite: SKSpriteNode) {
        targetSprite.removeAllActions()
        targetSprite.removeFromParent()
    }

    /// Function that selects which target to attack at which index with the help of row order priority and indices
    func selectTargetIndex(attackerFormationIndex: Int, opposingFormation: [Int], attackType: Character.AttackType, isTargetEnemy: Bool) -> Int? {
        let columns = 5
        let attackerRowPriority = attackerFormationIndex / columns
        let rowOrder: [Int]
        
        switch attackerRowPriority {
        case 0:
            rowOrder = [0, 1, 2]
        case 1:
            rowOrder = [1, 2, 0]
        case 2:
            rowOrder = [2, 0, 1]
        default:
            rowOrder = [0, 0, 0]
        }

        for row in rowOrder {
            let start = row * columns
            let end = start + columns
            
            let indices = (start..<end).filter { opposingFormation[$0] != 0 }
            
            if !indices.isEmpty {
                if isTargetEnemy {
                    switch attackType {
                    case .Front:
                        return indices.first
                    case .Skip:
                        return indices.count > 1 ? indices[1] : indices.first
                    case .Back:
                        return indices.last
                    }
                } else {
                    switch attackType {
                    case .Front:
                        return indices.last
                    case .Skip:
                        return indices.count > 1 ? indices[indices.count - 2] : indices.first /// Checks the second from the back for mirror effect
                    case .Back:
                        return indices.first
                    }
                }
            }
        }
        return nil
    }
    
    /// To retrieve index of where a player character is placed
    func getPlayerHexagonIndex(characterId: Int) -> Int? {
        guard let gameScene = gameScene else { return nil }
        return gameScene.playerPlacementArray.firstIndex(where: { $0 == characterId })
    }
    
    /// To retrieve the index of where a enemy character is placed
    func getEnemyHexagonIndex(characterID: Int) -> Int? {
        // Returns the index in enemyPlacementArray where the character is placed.
        return enemyPlacementArray.firstIndex(where: { $0 == characterID })
    }
    
    /// To retrieve player characters currently on the board
    func getPlayerCharacter(hexIndex: Int) -> Character? {
        guard let gameScene = gameScene else { return nil }
        
        let id = gameScene.playerPlacementArray[hexIndex]
        guard id != 0 else { return nil }
        return Characters.allCharacters.first { $0.id == id }
    }

    /// To retrieve enemy characters currently on the board
    func getEnemyCharacter(hexIndex: Int) -> Character? {
        let id = enemyPlacementArray[hexIndex]
        guard id != 0 else { return nil }
        return Characters.allCharacters.first { $0.id == id }
    }
}

/// For turn queue structure
struct CharacterOnBoard {
    let character: Character
    let isEnemy: Bool
}

