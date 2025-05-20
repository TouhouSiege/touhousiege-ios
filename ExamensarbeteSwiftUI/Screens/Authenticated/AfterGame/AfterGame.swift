//
//  AfterGame.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-20.
//

import SwiftUI

struct AfterGame: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    var isComputerPlaying: Bool
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .game(isComputerPlaying: isComputerPlaying))
                }, text: "Play Again")
                .offset(y: -width * TouhouSiegeStyle.Decimals.xSmall)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .home)
                }, text: "Home")
            }
        }
        .frame(maxWidth: width, maxHeight: height)
        .scaledToFill()
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    AfterGame(isComputerPlaying: false)
}
