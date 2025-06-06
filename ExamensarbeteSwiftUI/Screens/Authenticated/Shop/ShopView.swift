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
    
    @StateObject var vm = ShopViewModel()
    
    @State var buyTitle: String = ""
    @State var buyText: String = ""
    @State var whichTab: Int = 1
    @State var whichItem: Int = 0
    @State var confirmDialog: Bool = false
    @State var isAnimating = false
    @State var isAnimatingBack = false
    
    var body: some View {
        ZStack {
            ZStack {
                BackgroundMain(title: "Shop")
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
                            }, titel: "Diamond Pack 1", text: "400 Diamonds", cost: "6.99€", imageBigIcon: Image(TouhouSiegeStyle.Images.diamondSmall))
                            
                            ShopItemLister(function: {
                                whichItem = 2
                                buyTitle = "Diamond Pack 2"
                                buyText = "900 Diamonds"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Diamond Pack 2", text: "900 Diamonds", cost: "12.99€", imageBigIcon: Image(TouhouSiegeStyle.Images.diamondMedium))
                            
                            ShopItemLister(function: {
                                whichItem = 3
                                buyTitle = "Diamond Pack 3"
                                buyText = "2000 Diamonds"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Diamond Pack 3", text: "2000 Diamonds", cost: "24.99€", imageBigIcon: Image(TouhouSiegeStyle.Images.diamondLarge))
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
                            }, titel: "Stamina Pack", text: "120 Stamina", cost: "750", imageButton: Image(TouhouSiegeStyle.Images.gold01), imageBigIcon: Image(TouhouSiegeStyle.Images.staminaSmall))
                            
                            ShopItemLister(function: {
                                whichItem = 102
                                buyTitle = "Gold Pack 1"
                                buyText = "400 Gold"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Gold Pack 1", text: "400 Gold", cost: "100", imageButton: Image(TouhouSiegeStyle.Images.diamond01), imageBigIcon: Image(TouhouSiegeStyle.Images.goldSmall))
                            
                            ShopItemLister(function: {
                                whichItem = 103
                                buyTitle = "Gold Pack 1"
                                buyText = "1000 Gold"
                                confirmDialog = true
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                    isAnimating.toggle()
                                }
                            }, titel: "Gold Pack 2", text: "1000 Gold", cost: "200", imageButton: Image(TouhouSiegeStyle.Images.diamond01), imageBigIcon: Image(TouhouSiegeStyle.Images.goldlarge))
                        }
                    }
                }
                .opacity(isAnimatingBack ? 0 : 1)
                
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
            .disabled(confirmDialog)
            .disabled(vm.confirmDialogError)
            
            if confirmDialog {
                    ConfirmDialog(functionYes: {
                        Task {
                            switch whichItem {
                            case 1: await vm.purchaseDiamonds(amount: 400)
                            case 2: await vm.purchaseDiamonds(amount: 900)
                            case 3: await vm.purchaseDiamonds(amount: 2000)
                            case 101: await vm.purchaseStamina(amount: 120, cost: 750)
                            case 102: await vm.purchaseGold(amount: 400, cost: 100)
                            case 103: await vm.purchaseGold(amount: 1000, cost: 200)
                            default: print("Error purchasing item!")
                            }
                            
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isAnimating.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                Task {
                                    do {
                                        try await userManager.getUser()
                                        vm.user = userManager.user
                                        vm.userManager = userManager
                                    } catch let error {
                                        print("Error loading user: \(error)")
                                    }
                                    
                                    whichItem = 0
                                    buyTitle = ""
                                    buyText = ""
                                    confirmDialog = false
                                }
                            })
                        }
                    }, functionNo: {
                        withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                            isAnimating.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.small, execute: {
                            whichItem = 0
                            buyTitle = ""
                            buyText = ""
                            confirmDialog = false
                        })
                        
                    }, title: "Are you sure about this purchase?", buyTitle: buyTitle, buyText: buyText)
                    .opacity(isAnimating ? 1 : 0)
            }
            
            if vm.confirmDialogError {
                ErrorDialog(functionOk: {
                    vm.confirmDialogError = false
                }, title: "Purchase Failed!")
            }
        }
        .onAppear {
            vm.apiManager = apiAuthManager
            vm.user = userManager.user
            vm.userManager = userManager
            
            isAnimatingBack = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.Decimals.xSmall, execute: {
                isAnimatingBack = false
            })
        }
        
        .disabled(isAnimatingBack)
    }
}
