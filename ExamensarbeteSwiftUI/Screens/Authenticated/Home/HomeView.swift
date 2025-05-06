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
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            VStack {
                Text("\(String(describing: apiAuthManager.username))")
                Text("\(String(describing: userManager.user))")
            }
            
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
                
                ButtonBig(function: {
                    apiAuthManager.logoutUser()
                    navigationManager.navigateTo(screen: .landing)
                }, text: "Log Out")
            }
        }.task {
            if apiAuthManager.token != nil && apiAuthManager.username != nil {
                do {
                    try await userManager.getUser()
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
    HomeView().environmentObject(NavigationManager())
}
