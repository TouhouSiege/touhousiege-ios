//
//  AboutView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var isAnimatingBack: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "About")
            
            if userManager.user != nil {
                TopNavBar()
            }
            
            VStack {
                Text("Touhou Siege is a strategized turn based project which has taken inspiration from the games created by the renowned ZUN from Team Shanghai Alice. The game is a work in progress and is not yet completely finished but is currently done with the MVP in mind. \n\n All credits go to ZUN and Team Shanghai Alice for creating the original games and for creating the universe known as Touhou")
                    .font(TouhouSiegeStyle.FontSize.small.bold())
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                    .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.medium, maxHeight: height * TouhouSiegeStyle.BigDecimals.xMedium)
            }
            .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.xMedium, maxHeight: height * TouhouSiegeStyle.BigDecimals.Large)
            .background {
                RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                    .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                    .stroke(Color(TouhouSiegeStyle.Colors.brownLight), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            }
            
            VStack {
                Spacer()
                
                HStack {
                    ButtonBig(function: {
                        withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                            isAnimatingBack = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                            navigationManager.navigateTo(screen: .home)
                        })
                    }, text: "Back").offset(x: width * TouhouSiegeStyle.Decimals.medium, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                    
                    Spacer()
                }
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
    AboutView()
}
