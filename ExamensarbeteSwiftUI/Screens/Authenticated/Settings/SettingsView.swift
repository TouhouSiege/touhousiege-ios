//
//  SettingsView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Settings")
            TopNavBar()
            
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .home)
                }, text: "Back")
                
                ButtonBig(function: {
                    userManager.user = nil
                    apiAuthManager.logoutUser()
                    navigationManager.navigateTo(screen: .landing)
                }, text: "Log Out")
            }
        }
    }
}

#Preview {
    SettingsView()
}
