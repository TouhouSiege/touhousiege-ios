//
//  GameView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var userManager: UserManager
    
    @State var isHidden: Bool = false
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    let vm = GameViewModel()
    
    @State var gameScene: GameScene = GameScene()
   
    var body: some View {
        ZStack {
            VStack {
                SpriteView(scene: gameScene)
                    .edgesIgnoringSafeArea(.all)
            }.onDisappear { /// For memory purposes
                gameScene.removeAllChildren()
                gameScene.removeFromParent()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    if !isHidden {
                        HStack {
                            ButtonSmall(function: {
                                isHidden = true
                                vm.startGame()
                            }, text: "Start")
                            .offset(x: -width * TouhouSiegeStyle.Decimals.xSmall)
                            
                            ButtonSmall(function: {
                                navigationManager.navigateTo(screen: .play)
                            }, text: "Cancel")
                        }.offset(x: -width * TouhouSiegeStyle.Decimals.small, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                    }
                }
            }
        }.onAppear {
            gameScene.vm = vm
            gameScene.user = userManager.user
            gameScene.isDefenseSetting = false
            
            /** Workaround cause UIScreen.main.bounds.width/height doesn't always work when working with newer phone models
             *  leaving undesired space at some places (probably some wonky bug with mixing spritekit and swiftui - personal guess)
             */
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let fullScreen = UIScreen.main.bounds.size
                
                let width = fullScreen.width - window.safeAreaInsets.left - window.safeAreaInsets.right
                let height = fullScreen.height - window.safeAreaInsets.top - window.safeAreaInsets.bottom
                
                gameScene.size = CGSize(width: width, height: height)
                gameScene.scaleMode = .fill
                
                let randomBackground = SKSpriteNode(imageNamed: vm.randomBackgroundGenerator())
                randomBackground.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2)
                randomBackground.size = gameScene.size
                
                let randomBackgroundOverlay = SKSpriteNode(color: .black, size: gameScene.size)
                randomBackgroundOverlay.alpha = TouhouSiegeStyle.BigDecimals.small
                randomBackgroundOverlay.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2)
                
                gameScene.addChild(randomBackground)
                gameScene.addChild(randomBackgroundOverlay)

                
                
            } else {
                print("ERROR LOADING GAME...")
            }
        }
    }
}

#Preview {
    GameView()
}




