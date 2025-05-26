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
    
    @State var isAnimatingBack: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Settings")
            TopNavBar()
            
            VStack {
                ButtonBig(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimatingBack = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .home)
                    })
                }, text: "Back")
                
                ButtonBig(function: {
                    userManager.user = nil
                    apiAuthManager.logoutUser()
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimatingBack = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .landing)
                    })
                }, text: "Log Out")
            }
            .opacity(isAnimatingBack ? 0 : 1)
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
    SettingsView()
}
