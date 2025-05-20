//
//  GachaView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import SwiftUI

struct GachaView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    let vm = GachaViewModel()
    
    var body: some View {
        ZStack {
            BackgroundMain()
            TopNavBar()
            
            VStack {
                Spacer()
                
                HStack {
                    ButtonBig(function: {
                        navigationManager.navigateTo(screen: .home)
                    }, text: "Back").offset(x: width * TouhouSiegeStyle.Decimals.medium, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                    
                    Spacer()
                    
                    HStack {
                        ButtonBig(function: {
                            
                        }, text: "Roll x 1")
                        
                        ButtonBig(function: {
                            Task {
                                await vm.rollTenCharacters()
                            }
                        }, text: "Roll x 10")
                    }.offset(x: -width * TouhouSiegeStyle.Decimals.medium, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                }
            }
        }
        .onAppear {
            vm.apiManager = apiAuthManager
            vm.user = userManager.user
        }
    }
}

#Preview {
    GachaView()
}
