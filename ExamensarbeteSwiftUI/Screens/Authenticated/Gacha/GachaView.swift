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
    
    @StateObject var vm = GachaViewModel()
    
    @State var isAnimating = false
    @State var isAnimatingBack = false
    
    var body: some View {
        ZStack {
            ZStack {
                BackgroundMain(title: "Gacha")
                GachaBanner(title: "Gensokyo Beginner", text: "\nTry your luck at rolling a brand new character. \n\nMay or may not inflict serious injury on your wallet!", image: Image(TouhouSiegeStyle.Images.koishiKomeijiProfileLarge))
                    .opacity(isAnimatingBack ? 0 : 1)
                
                TopNavBar()
                
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
                        
                        HStack {
                            ButtonBig(function: {
                                Task {
                                    await vm.rollOneCharacter(cost: 100)
                                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                        isAnimating.toggle()
                                    }
                                }
                            }, text: "Roll x 1")
                            
                            ButtonBig(function: {
                                Task {
                                    await vm.rollTenCharacters(cost: 1000)
                                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                                        isAnimating.toggle()
                                    }
                                }
                            }, text: "Roll x 10")
                        }
                        .offset(x: -width * TouhouSiegeStyle.Decimals.medium, y: -width * TouhouSiegeStyle.Decimals.xSmall)
                    }
                }
                .opacity(isAnimatingBack ? 0 : 1)
            }
            .onAppear {
                vm.apiManager = apiAuthManager
                vm.user = userManager.user
            }
            .disabled(vm.successfullyRolled)
            .disabled(vm.confirmDialogError)
            
            
            if vm.successfullyRolled {
                GachaDialog(functionOk: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.small)) {
                        isAnimating.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.small, execute: {
                        Task {
                            do {
                                try await userManager.getUser()
                                vm.user = userManager.user
                                vm.userManager = userManager
                            } catch let error {
                                print("Error loading user: \(error)")
                            }
                            
                            vm.rolledCharacters = []
                            vm.successfullyRolled = false
                        }
                    })
                }, title: "Congratulations, you got:", text: "\(vm.rolledCharacters.joined(separator: "\n"))")
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

#Preview {
    GachaView()
}
