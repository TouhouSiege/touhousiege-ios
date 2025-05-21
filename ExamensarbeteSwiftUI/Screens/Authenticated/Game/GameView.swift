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
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    var isComputerPlaying: Bool
    
    @State var isHidden: Bool = false
    @State var isWinnerFound = false
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @StateObject var vm = GameViewModel()
    @StateObject var checkForCharactersPlaced = CheckForCharactersPlaced()
    @State var gameScene: GameScene = GameScene()
    @State var endGameText: String = ""
    @State var opacityAnimationResultText: Double = 0.0
    @State var opacityAnimationContinueText: Double = 0.0
    
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
                if vm.isGameOver {
                    ZStack {
                        Color.black
                            .opacity(opacityAnimationResultText)
                            .edgesIgnoringSafeArea(.all)
                            .onAppear {
                                withAnimation(.easeIn(duration: 2.5)) {
                                    opacityAnimationResultText = TouhouSiegeStyle.BigDecimals.xxLarge
                                }
                            }
                        ZStack {
                            Text(endGameText)
                                .font(TouhouSiegeStyle.FontSize.ultra)
                                .foregroundColor(.white)
                                .opacity(opacityAnimationResultText)
                                .onAppear {
                                    withAnimation(.easeIn(duration: 2.5)) {
                                        opacityAnimationResultText = TouhouSiegeStyle.BigDecimals.xxLarge
                                    }
                                }
                                .offset(y: -width * TouhouSiegeStyle.Decimals.medium)
                            
                            if isWinnerFound {
                                Text("Press anywhere to continue")
                                    .font(TouhouSiegeStyle.FontSize.large)
                                    .foregroundColor(.white)
                                    .opacity(opacityAnimationContinueText)
                                    .onAppear {
                                        withAnimation(Animation.easeIn(duration: 1.0).repeatForever(autoreverses: true)) {
                                            opacityAnimationContinueText = TouhouSiegeStyle.BigDecimals.xxLarge
                                        }
                                    }
                                    .offset(y: width * TouhouSiegeStyle.Decimals.medium)
                            }
                        }
                    }.onAppear {
                        if vm.playerWon {
                            endGameText = "You Won"
                        } else {
                            endGameText = "You Lose"
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            isWinnerFound = true
                        }
                    }
                }
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
                            .disabled(!checkForCharactersPlaced.isCharactersPlaced)
                            .opacity(checkForCharactersPlaced.isCharactersPlaced ? 1 : 0.3)
                            
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
            gameScene.isComputerPlaying = isComputerPlaying
            gameScene.checkForCharactersPlaced = checkForCharactersPlaced
            vm.user = userManager.user
            vm.apiAuthManager = apiAuthManager
            
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
                
                if !isComputerPlaying {
                    Task {
                        do {
                            guard let user = userManager.user else { return }
                            
                            let response = try await apiAuthManager.getRandomPlayer(user: user)
                            
                            if response.success {
                                if let randomPlayer = response.user {
                                    gameScene.enemyPlacementArrayPlayer = randomPlayer.defense
                                    gameScene.enemyUser = randomPlayer
                                    vm.enemyUser = randomPlayer
                                    vm.enemyPlacementArrayComputer = randomPlayer.defense
                                    
                                }
                            }
                        } catch let error {
                            print("Error loading random enemy player: \(error)")
                        }
                    }
                }
            } else {
                print("ERROR LOADING GAME...")
            }
        }
        .onTapGesture {
            if isWinnerFound {
                navigationManager.navigateTo(screen: .afterGame(isComputerPlaying: isComputerPlaying))
            }
        }
    }
}

#Preview {
    GameView(isComputerPlaying: true)
}




