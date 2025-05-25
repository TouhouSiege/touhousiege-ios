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
    
    let vm = ShopViewModel()
    
    @State var buyTitle: String = ""
    @State var buyText: String = ""
    @State var whichTab: Int = 1
    @State var whichItem: Int = 0
    @State var confirmDialog: Bool = false
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
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
                                whichItem = 1
                                buyTitle = "Diamond Pack 1"
                                buyText = "400 Diamonds"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Diamond Pack 1", text: "400 Diamonds", cost: "6.99€")
                            
                            ShopItemLister(function: {
                                whichItem = 2
                                buyTitle = "Diamond Pack 2"
                                buyText = "900 Diamonds"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Diamond Pack 2", text: "900 Diamonds", cost: "12.99€")
                            
                            ShopItemLister(function: {
                                whichItem = 3
                                buyTitle = "Diamond Pack 3"
                                buyText = "2000 Diamonds"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Diamond Pack 3", text: "2000 Diamonds", cost: "24.99€")
                        }
                        
                        if whichTab == 2 {
                            ShopItemLister(function: {
                                whichItem = 101
                                buyTitle = "Stamina Pack"
                                buyText = "120 Stamina"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Stamina Pack", text: "120 Stamina", cost: "750", image: Image(TouhouSiegeStyle.Images.gold01))
                            
                            ShopItemLister(function: {
                                whichItem = 102
                                buyTitle = "Gold Pack 1"
                                buyText = "400 Gold"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Gold Pack 1", text: "400 Gold", cost: "100", image: Image(TouhouSiegeStyle.Images.diamond01))
                            
                            ShopItemLister(function: {
                                whichItem = 103
                                buyTitle = "Gold Pack 1"
                                buyText = "1000 Gold"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
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
            }.disabled(confirmDialog)
            
            if confirmDialog {
                    ConfirmDialog(functionYes: {
                        Task {
                            switch whichItem {
                            case 1: await vm.purchaseDiamonds(amount: 400)
                            case 2: await vm.purchaseDiamonds(amount: 900)
                            case 3: await vm.purchaseDiamonds(amount: 2000)
                            default: print("Error purchasing item!")
                            }
                            
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isAnimating.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                whichItem = 0
                                buyTitle = ""
                                buyText = ""
                                confirmDialog = false
                            })
                        }
                    }, functionNo: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isAnimating.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                            whichItem = 0
                            buyTitle = ""
                            buyText = ""
                            confirmDialog = false
                        })
                        
                    }, title: "Are you sure about this purchase?", buyTitle: buyTitle, buyText: buyText)
                    .opacity(isAnimating ? 1 : 0)
            }
        }
        .onAppear {
            vm.apiManager = apiAuthManager
            vm.user = userManager.user
        }
    }
}
