//
//  DefenseView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-20.
//

import SwiftUI
import SpriteKit

struct DefenseView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    let vmGameLogic = GameViewModel()
    let vm = DefenseViewModel()
    
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
                    
                    HStack {
                        ButtonSmall(function: {
                            Task {
                                await vm.updateDefense(defense: gameScene.playerPlacementArray)
                                navigationManager.navigateTo(screen: .play)
                            }
                        }, text: "Save")
                        .offset(x: -width * TouhouSiegeStyle.Decimals.xSmall)
                        
                        ButtonSmall(function: {
                            navigationManager.navigateTo(screen: .play)
                        }, text: "Cancel")
                    }.offset(x: -width * TouhouSiegeStyle.Decimals.small, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                }
            }
        }.onAppear {
            gameScene.vm = vmGameLogic
            gameScene.user = userManager.user
            gameScene.isDefenseSetting = true
            
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
                
                let randomBackground = SKSpriteNode(imageNamed: vmGameLogic.randomBackgroundGenerator())
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
            
            vm.apiManager = apiAuthManager
            vm.user = userManager.user
        }
    }
}

#Preview {
    DefenseView()
}




