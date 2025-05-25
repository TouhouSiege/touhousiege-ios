//
//  LoggedInLandingPage.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var testText = "Not loaded yet..."
    @State var hasCharacters = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Home")
            TopNavBar()
            
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .play)
                }, text: "Play").offset(x: width * 0.25)
                    .disabled(!hasCharacters)
                    .opacity(hasCharacters ? 1 : 0.5)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .gacha)
                }, text: "Gacha").offset(x: width * 0.22)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .shop)
                }, text: "Shop").offset(x: width * 0.22)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .characters)
                }, text: "Characters").offset(x: width * 0.25)
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .about)
                }, text: "About").offset(x: width * 0.28)
            }.offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
        }.task {
            if apiAuthManager.token != nil && apiAuthManager.username != nil {
                do {
                    try await userManager.getUser()
                    
                    if let user = userManager.user {
                        hasCharacters = !user.characters.isEmpty
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
    }
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager())
        .environmentObject(UserManager(apiAuthManager: ApiAuthManager()))
        .environmentObject(ApiAuthManager())
}
