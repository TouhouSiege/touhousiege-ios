//
//  ShopView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-03.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var whichTab: Int = 1
    
    var body: some View {
        ZStack {
            BackgroundMain()
            TopNavBar()
            
            VStack {
                HStack {
                    VStack {
                        ButtonMedium(function: {
                            whichTab = 1
                            }, text: "Diamond")
                        .disabled(whichTab == 1)
                        .opacity(whichTab == 1 ? TouhouSiegeStyle.BigDecimals.Large : 1)
                        
                        ButtonMedium(function: {
                            whichTab = 2
                        }, text: "Gold")
                        .disabled(whichTab == 2)
                        .opacity(whichTab == 2 ? TouhouSiegeStyle.BigDecimals.Large : 1)
                    }
                    
                    if whichTab == 1 {
                        ShopItemLister(function: {
                            
                        }, titel: "Diamond Pack 1", text: "400 Diamonds", cost: "6.99€")
                        
                        ShopItemLister(function: {
                            
                        }, titel: "Diamond Pack 2", text: "900 Diamonds", cost: "12.99€")
                        
                        ShopItemLister(function: {
                            
                        }, titel: "Diamond Pack 3", text: "2000 Diamonds", cost: "24.99€")
                    }
                    
                    if whichTab == 2 {
                        ShopItemLister(function: {
                            
                        }, titel: "Stamina Pack", text: "120 Stamina", cost: "750", image: Image(TouhouSiegeStyle.Images.gold01))
                            
                        ShopItemLister(function: {
                            
                        }, titel: "Gold Pack 1", text: "400 Gold", cost: "100", image: Image(TouhouSiegeStyle.Images.diamond01))
                        
                        ShopItemLister(function: {
                            
                        }, titel: "Gold Pack 2", text: "1000 Gold", cost: "200", image: Image(TouhouSiegeStyle.Images.diamond01))
                    }
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    ButtonBig(function: {
                        navigationManager.navigateTo(screen: .home)
                    }, text: "Back").offset(x: width * TouhouSiegeStyle.Decimals.medium, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                    
                    Spacer()
                }
            }
        }
    }
}
