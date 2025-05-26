//
//  PlayGameView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-20.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var isDefenseSet: Bool = false
    @State var isAnimatingBack: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Play")
            TopNavBar()
            
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .game(isComputerPlaying: true))
                }, text: "Player vs Computer").offset(x: -width * 0.2)
                    .disabled(!isDefenseSet)
                    .opacity(isDefenseSet ? 1 : 0.5)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .game(isComputerPlaying: false))
                }, text: "Player vs Player").offset(x: -width * 0.17)
                    .disabled(!isDefenseSet)
                    .opacity(isDefenseSet ? 1 : 0.5)
                
                ButtonBig(function: {
                }, text: "Colosseum").offset(x: -width * 0.17)
                    .disabled(true)
                    .opacity(0.5)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .defense)
                }, text: "Defense").offset(x: -width * 0.2)
                
                ButtonBig(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimatingBack = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .home)
                    })
                }, text: "Back").offset(x: -width * 0.23)
            }
                .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
                .opacity(isAnimatingBack ? 0 : 1)
            
            RankingList()
                .position(x: width - (width / 3), y: height / 2)
                .opacity(isAnimatingBack ? 0 : 1)
        }.task {
            if apiAuthManager.token != nil && apiAuthManager.username != nil {
                do {
                    try await userManager.getUser()
                    
                    if let user = userManager.user {
                        isDefenseSet = !user.defense.isEmpty
                    }
                } catch let error {
                    print("Error loading user: \(error)")
                    apiAuthManager.token = nil
                    apiAuthManager.username = nil
                    userManager.user = nil
                    navigationManager.navigateTo(screen: .landing)
                }
            } else {
                apiAuthManager.token = nil
                apiAuthManager.username = nil
                userManager.user = nil
                navigationManager.navigateTo(screen: .landing)
            }
        }
        
        .onAppear {
            isAnimatingBack = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.Decimals.xSmall, execute: {
                isAnimatingBack = false
            })
        }
        
        .disabled(isAnimatingBack)
    }
}

#Preview {
    PlayView()
        .environmentObject(NavigationManager())
        .environmentObject(UserManager(apiAuthManager: ApiAuthManager()))
        .environmentObject(ApiAuthManager())
}

