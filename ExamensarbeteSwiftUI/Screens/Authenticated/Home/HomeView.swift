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
            BackgroundMain()
            TopNavBar()
            
            VStack {
                Text("\(String(describing: apiAuthManager.username))")
                Text("\(String(describing: userManager.user))")
            }
            
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .game)
                }, text: "Play").offset(x: width * 0.15)
                    .disabled(!hasCharacters)
                    .opacity(hasCharacters ? 1 : 0.5)
                
                ButtonBig(function: {
                    Task {
                        do {
                            guard let userId = userManager.user?.id else {
                                print("No user id found.")
                                return
                            }
                            let response = try await apiAuthManager.tempGetCharacters(userId: userId, characters: [
                                Characters.allCharacters[0].id,
                                Characters.allCharacters[1].id,
                                Characters.allCharacters[2].id
                            ])
                            print("Characters updated successfully: \(response)")
                            hasCharacters = true
                        } catch let error {
                            print("Error updating characters: \(error)")
                        }
                    }
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
