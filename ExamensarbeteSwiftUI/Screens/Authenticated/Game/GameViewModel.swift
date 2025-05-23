//
//  GameViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import Foundation
import SpriteKit

class GameViewModel: ObservableObject {
    weak var gameScene: GameScene?
    
    var user: User?
    var apiAuthManager: ApiAuthManager?
    var enemyUser: User?
    
    let width = UIScreen.main.bounds.width
    
    var playerHexagonCoordinates: [CGPoint] = []
    var enemyHexagonCoordinates: [CGPoint] = []
    
    var playerSpritesHexaCoord: [SKSpriteNode?] = Array(repeating: nil, count: 15)
    var enemySpritesHexaCoord: [SKSpriteNode?] =  Array(repeating: nil, count: 15)
    
    var turnQueueArray: [CharacterOnBoard] = []
    var turnQueueIndexOfWhosTurn = 0
    var roundNumber: Int = 0
    
    /// Arrays for player vs computer
    
    var enemyPlacementArrayComputer: [GameCharacter?] = {
        let randomArrayNumber =  1
        
        switch randomArrayNumber {
        case 1: return [nil, nil, nil, nil, Characters.allCharacters[5], nil, nil, nil, Characters.allCharacters[6], Characters.allCharacters[7], nil, nil, nil, nil, Characters.allCharacters[8]]
        default: return []
        }
    }()
    
    var playerWon: Bool = false
    var enemyWon: Bool = false
    @Published var isGameOver: Bool = false {
        didSet {
            if playerWon {
                Task {
                    await winner(enemyWon: false)
                }
            }
            
            if enemyWon {
                Task {
                    await winner(enemyWon: true)
                }
            }
        }
    }
    
    var observableBoolGameStatus: Bool = false
    
    /// Generates a random background for the gamescene
    func randomBackgroundGenerator() -> String {
        let randomBackground = Int.random(in: 0...7)
        
        return TouhouSiegeStyle.Images.bg_play[randomBackground]
    }
    
    func randomEnemyDelayFunction() {
        guard let gameScene = gameScene else { return }
        
        let enemyPlacementArrayPlayer = gameScene.enemyPlacementArrayPlayer
        
        gameScene.placeEnemyCharacters(enemyArray: enemyPlacementArrayPlayer)
    }
    
    func checkIfEnemyPlayerIsComputer() {
        guard let isComputerPlaying = gameScene?.isComputerPlaying else { return }
        
        if !isComputerPlaying {
            guard let enemyUserDefense = enemyUser?.defense else { return }
            
            enemyPlacementArrayComputer = enemyUserDefense
        } else {
        }
    }
    
    func resetGame() {
        guard let characters = user?.characters else { return }
        for character in characters {
            character.stats.currentHp = character.stats.maxHp
        }
    }
    
    func startGame() {
        print("**********GAME STARTED!**********")
        
        checkIfEnemyPlayerIsComputer()
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
            if gameScene.playerPlacementArray[index]?.id != 0, let character = getPlayerCharacter(hexIndex: index) {
                characterTurnQueue.append(CharacterOnBoard(character: character, isEnemy: false))
            }
        }
        
        /// Adds enemy characters to the queue
        for index in 0..<enemyPlacementArrayComputer.count {
            if enemyPlacementArrayComputer[index]?.id != 0, let character = getEnemyCharacter(hexIndex: index) {
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
        if turnQueueArray[turnQueueIndexOfWhosTurn].character.stats.currentHp <= 0 {
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
        
        guard let characterToActIndex = getPlayerHexagonIndex(characterId: characterToAct.id ?? 0) else { return }
        guard let characterToActSprite = playerSpritesHexaCoord[characterToActIndex] else { return }
        guard let characterToAttackIndex = selectTargetIndex(attackerFormationIndex: characterToActIndex, opposingFormation: enemyPlacementArrayComputer, attackType: characterToAct.stats.attackType, isTargetEnemy: true) else { return }
        guard let characterToAttackSprite = enemySpritesHexaCoord[characterToAttackIndex] else { return }
   
        attackAnimationsAndOutcome(characterToActSprite: characterToActSprite, characterToAttackSprite: characterToAttackSprite, isTargetEnemy: true) {
            self.turnQueueIndexOfWhosTurn += 1
            self.characterPreTurnProcess()
        }
    }
    
    /// Enemy turn
    func enemyCharacterTurnProcess(characterOnBoard: CharacterOnBoard) {
        let characterToAct = characterOnBoard.character
        
        guard let gameScene = gameScene else { return }
        guard let characterToActIndex = getEnemyHexagonIndex(characterId: characterToAct.id ?? 0) else { return }
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
        
        let isEnemyAlive = enemyPlacementArrayComputer.contains { $0 != nil }
        let isPlayerAlive = gameScene.playerPlacementArray.contains { $0 != nil }
        
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
    func winner(enemyWon: Bool) async {
        if enemyWon {
            print("haha du förlorade")
        }
        
        if playerWon {
            print("grattis du vann!")
        }

        observableBoolGameStatus = true
        resetGame()
        
        guard let gameScene = gameScene else { return }
        guard let isComputerPlaying = await gameScene.isComputerPlaying else { return }
        
        await endOfGameCalculationsAndBackendCalls(isComputerPlaying: isComputerPlaying)
    }
    
    /// Function that checks what variable to update in the database if ethier player or computer or enemy player wins
    func endOfGameCalculationsAndBackendCalls(isComputerPlaying: Bool) async {
        guard let user = user else { return }
        guard let apiAuthManager = apiAuthManager else { return }
   
        if isComputerPlaying {
            if playerWon {
                do {
                    let response = try await apiAuthManager.updateEndOfGame(userId: user.id, caseGame: 1)
                    print(response.message)
                } catch let error {
                    print("Error updating PvM Winner: \(error)")
                }
            }
            
            if enemyWon {
                do {
                    let response = try await apiAuthManager.updateEndOfGame(userId: user.id, caseGame: 2)
                    print(response.message)
                } catch let error {
                    print("Error updating PvM Loser: \(error)")
                }
            }
        } else {
            guard let enemyUser = enemyUser else { return }
            
            if playerWon {
                do {
                    let response = try await apiAuthManager.updateEndOfGame(userId: user.id, caseGame: 3)
                    print(response.message)
                } catch let error {
                    print("Error updating PvP Winner: \(error)")
                }
                
                do {
                    let response = try await apiAuthManager.updateEndOfGame(userId: enemyUser.id, caseGame: 4)
                    print(response.message)
                } catch let error {
                    print("Error updating Enemy PvP Loser: \(error)")
                }
            }
            
            if enemyWon {
                do {
                    let response = try await apiAuthManager.updateEndOfGame(userId: user.id, caseGame: 4)
                    print(response.message)
                } catch let error {
                    print("Error updating PvP Loser: \(error)")
                }
                
                do {
                    let response = try await apiAuthManager.updateEndOfGame(userId: enemyUser.id, caseGame: 3)
                    print(response.message)
                } catch let error {
                    print("Error updating Enemy PvP Winnter: \(error)")
                }
            }
        }
    }
    
    func attackAnimationsAndOutcome(characterToActSprite: SKSpriteNode, characterToAttackSprite: SKSpriteNode, isTargetEnemy: Bool, completion: @escaping () -> Void) {
        characterToActSprite.removeAllActions() /// To remove the idle animation
        
        guard let characterToActName = characterToActSprite.name else { return }
        guard let characterToAttackName = characterToAttackSprite.name else { return }
        
        let characterToActOriginalZPosition = characterToActSprite.zPosition
        characterToActSprite.zPosition = 777
        
        if let texture = characterToActSprite.texture {
            let aspectRatio = texture.size().width / texture.size().height
            characterToActSprite.size = CGSize(width:  (width * TouhouSiegeStyle.Decimals.xxLarge) * aspectRatio, height: width * TouhouSiegeStyle.Decimals.xxLarge)
        }
        
        let attacker: GameCharacter? = isTargetEnemy ? user?.characters.first { $0.name == characterToActName } : enemyPlacementArrayComputer.compactMap { $0 }.first { $0.name == characterToActName }
        
        let defender: GameCharacter? = isTargetEnemy ? enemyPlacementArrayComputer.compactMap { $0 }.first { $0.name == characterToAttackName } : user?.characters.first { $0.name == characterToAttackName }
        
        guard let attackerData = attacker else { return }
        guard let characterToAttackData = defender else { return }

        /// Used before when characters werent unique
        /// let characterToAttackTeamCheck: GameCharacter.Team = isTargetEnemy ? .enemy : .player
        
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
            if characterToAttackData.stats.currentHp <= 0 {
                characterToAttackSprite.run(characterToAttackFaintAnimation)
            } else {
                self.gameScene?.startIdleAnimation(character: characterToAttackSprite, characterName: characterToAttackName)
            }
        }
        
        let characterToAttackRemovalAction = SKAction.run {
            if characterToAttackData.stats.currentHp <= 0 {
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

    
    func calculateAndApplyDamage(from attacker: GameCharacter, to target: GameCharacter, targetSprite: SKSpriteNode, isTargetEnemy: Bool) {
        let calculatedDamage = attacker.stats.attack - target.stats.defense
        
        guard calculatedDamage > 0 else { return print("You did nothing!") }
        
        target.stats.currentHp -= calculatedDamage
        
        print("\(isTargetEnemy ? "Player" : "Enemy") \(attacker.name) deals \(calculatedDamage) damage to \(isTargetEnemy ? "Enemy" : "Player") \(target.name)! Remaining HP: \(target.stats.currentHp)")

        
        if target.stats.currentHp <= 0 {
            print("\(isTargetEnemy ? "Enemy" : "Player") \(target.name) has fainted!")
            removeFaintedCharacterLogical(target, isTargetEnemy: isTargetEnemy)
        }
    }
    
    /// Remove all logical information if a character faints so the game won't freeze
    func removeFaintedCharacterLogical(_ target: GameCharacter, isTargetEnemy: Bool) {
        guard let gameScene = gameScene else { return }
        
        if isTargetEnemy {
            for i in 0..<enemyPlacementArrayComputer.count {
                if enemyPlacementArrayComputer[i]?.id == target.id {
                    enemyPlacementArrayComputer[i] = nil
                    break
                }
            }
        } else {
            for i in 0..<gameScene.playerPlacementArray.count {
                if gameScene.playerPlacementArray[i]?.id == target.id {
                    gameScene.playerPlacementArray[i] = nil
                    break
                }
            }
        }
    }
    
    /// Removes a character sprite that has fainted after a turn
    func removeFaintedCharacterVisual(_ target: GameCharacter, targetSprite: SKSpriteNode) {
        targetSprite.removeAllActions()
        targetSprite.removeFromParent()
    }

    /// Function that selects which target to attack at which index with the help of row order priority and indices
    func selectTargetIndex(attackerFormationIndex: Int, opposingFormation: [GameCharacter?], attackType: GameCharacter.AttackType, isTargetEnemy: Bool) -> Int? {
        
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
            let end = min(start + columns, opposingFormation.count)
            let indices = (start..<end).filter { opposingFormation[$0] != nil }
            
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
        
        return gameScene.playerPlacementArray.firstIndex(where: { $0?.id == characterId })
    }
    
    /// To retrieve the index of where a enemy character is placed
    func getEnemyHexagonIndex(characterId: Int) -> Int? {
        
        return enemyPlacementArrayComputer.firstIndex(where: { $0?.id == characterId })
    }
    
    /// To retrieve player characters currently on the board
    func getPlayerCharacter(hexIndex: Int) -> GameCharacter? {
        guard let gameScene = gameScene else { return nil }
        
        let characterData = gameScene.playerPlacementArray[hexIndex]
        
        guard characterData != nil else { return nil }
        
        return user?.characters.first { $0.id == characterData?.id }
    }

    /// To retrieve enemy characters currently on the board
    func getEnemyCharacter(hexIndex: Int) -> GameCharacter? {
        guard let characterData = enemyPlacementArrayComputer[hexIndex] else { return nil }
        
        let charactersNilFilter: [GameCharacter] = enemyPlacementArrayComputer.compactMap { $0 }
        
        return charactersNilFilter.first { $0.id == characterData.id }
    }

}

/// To track if a character is placed on the board
class CheckForCharactersPlaced: ObservableObject {
    @Published var isCharactersPlaced: Bool = false
}

/// For turn queue structure
struct CharacterOnBoard {
    let character: GameCharacter
    let isEnemy: Bool
}

