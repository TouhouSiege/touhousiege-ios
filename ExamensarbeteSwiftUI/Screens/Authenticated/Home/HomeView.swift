//
//  LoggedInLandingPage.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .game)
                }, text: "Play").offset(x: width * 0.15)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .gacha)
                }, text: "Gacha").offset(x: width * 0.12)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .shop)
                }, text: "Shop").offset(x: width * 0.12)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .characters)
                }, text: "Characters").offset(x: width * 0.15)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .about)
                }, text: "About").offset(x: width * 0.18)
            }
        }
    }
}

#Preview {
    HomeView().environmentObject(NavigationManager())
}
