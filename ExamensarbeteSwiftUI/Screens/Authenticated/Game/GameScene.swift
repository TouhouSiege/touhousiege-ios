//
//  GameScene.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-02.
//

import SpriteKit

class GameScene: SKScene {
    /// In SpriteKit screen doesnt start at 0 it starts in the middle so this is needed to be able to make use of the whole width easier dynamically
    let middleScreen = UIScreen.main.bounds.width / 2
    let width = UIScreen.main.bounds.width
    
    
    override func didMove(to view: SKView) {
        print("Scene Loaded!")
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        
        createAlien(xy: CGPoint(x: 500, y: 250), color: .red)
        generateAliens()
    }
    
    func createPlatform() {
        let platform = SKSpriteNode()
        platform.size = CGSize(width: width, height: 50)
        platform.color = .blue
        platform.position = CGPoint(x: middleScreen, y: 150)
        
        platform.physicsBody = SKPhysicsBody(rectangleOf: platform.size)
        
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.affectedByGravity = false
        
        self.addChild(platform)
    }
    
    func generateAliens() {
        let startY = 300
        var startX = 200
        
        for _ in 1...5 {
            createAlien(xy: CGPoint(x: startX, y: startY), color: .green)
            startX += 50
        }
        
        startX = 200
        
        for _ in 1...5 {
            createAlien(xy: CGPoint(x: startX, y: startY - 50), color: .green)
            startX += 50
        }
        
        startX = 200
        
        for _ in 1...5 {
            createAlien(xy: CGPoint(x: startX, y: startY - 100), color: .green)
            startX += 50
        }
    }
    
    func createAlien(xy: CGPoint, color: UIColor) {
        let alien = SKSpriteNode()
        
        alien.size = CGSize(width: 25, height: 25)
        alien.color = color
        alien.position = xy
        alien.name = "alien"
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.frame.size)
        alien.physicsBody?.isDynamic = false
        alien.physicsBody?.affectedByGravity = false
        alien.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(alien)
        
        let moveRight = SKAction.move(by: CGVector(dx: 110, dy: 0), duration: 1.0)
        let moveLeft = SKAction.move(by: CGVector(dx: -110, dy: 0), duration: 1.0)
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -50), duration: 0.5)
        let wait = SKAction.wait(forDuration: 0.5)
        
        let sequence = SKAction.sequence([moveRight, moveLeft, moveDown, wait])
        
        let repeatSequence = SKAction.repeatForever(sequence)
        
        alien.run(repeatSequence)
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let square = SKSpriteNode()
            
            square.size = CGSize(width: 30, height: 30)
            
            let location = touch.location(in: self)
            square.position = location
            square.color = .green
            
            square.physicsBody = SKPhysicsBody(rectangleOf: square.size)
            
            square.physicsBody?.isDynamic = true
            square.physicsBody?.affectedByGravity = true
            
            
            addChild(square)
        }
    }*/
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            //square.position = location
            
            let move = SKAction.move(to: location, duration: 1.0)
            let rotate = SKAction.rotate(byAngle: 90.0, duration: 1.0)
            
            let sequence = SKAction.sequence([move, rotate])
            square.run(sequence)
        }
    }*/
    
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let move = SKAction.move(to: location, duration: .zero)
            square.run(move)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let move = SKAction.move(to: CGPoint(x: 0, y: 0), duration: .zero)
        square.run(move)
    }
     */
}
