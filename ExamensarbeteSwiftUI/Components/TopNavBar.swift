//
//  TopNavBar.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-04.
//

import SwiftUI

struct TopNavBar: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var diamondIndex = 0
    @State var goldIndex = 0
    
    var body: some View {
        ZStack {
            VStack {
                Color.black.opacity(0.8)
                    .frame(width: width, height: UIScreen.main.bounds.height * 0.15)
                    .border(.thinMaterial, width: 2)
                Spacer()
            }
            
            VStack {
                if let user = userManager.user {
                    ZStack {
                        HStack {
                            Button(action: {
                                navigationManager.navigateTo(screen: .home)
                            }) {
                                Image(systemName: "house")
                                    .resizable()
                                    .frame(width: height * 0.075, height: height * 0.075)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, width * 0.08)
                        .position(x: width * 0.07, y: height * 0.075)
                            
                        HStack {
                            HStack {
                                Image(navBarIcon(image: TouhouSiegeEnums.stamina.rawValue)[0])
                                    .resizable()
                                    .frame(width: height * 0.06, height: height * 0.06)
                                
                                Text("\(user.stamina)").font(TouhouSiegeStyle.FontSize.xMedium)
                                    .foregroundStyle(.white)
                            }.padding(.trailing, width * 0.01)
                            
                            HStack {
                                imageLooping(arrayOfStrings: navBarIcon(image: TouhouSiegeEnums.diamond.rawValue), index: $diamondIndex)
                                
                                Text("\(user.diamonds)").font(TouhouSiegeStyle.FontSize.xMedium)
                                    .foregroundColor(.white)
                            }.padding(.horizontal, width * 0.01)
                            
                            HStack {
                                imageLooping(arrayOfStrings: navBarIcon(image: TouhouSiegeEnums.gold.rawValue), index: $goldIndex)
                                Text("\(user.gold)").font(TouhouSiegeStyle.FontSize.xMedium)
                                    .foregroundStyle(.white)
                            }.padding(.leading, width * 0.01)
                        }.position(x: width * 0.5, y: height * 0.075)
                        
                        HStack {
                            Button(action: {
                                navigationManager.navigateTo(screen: .settings)
                            }) {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: height * 0.075, height: height * 0.075)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, -width * 0.17)
                        .position(x: width - width * 0.04, y: height * 0.075)
                    }
                    .frame(width: width, height: UIScreen.main.bounds.height * 0.15)
                    .offset(x: width * 0.05)
                    
                    Spacer()
                }
            }
        }
    }
}

func navBarIcon(image: String) -> [String] {
    if image == TouhouSiegeEnums.stamina.rawValue {
        return [
            TouhouSiegeStyle.Images.stamina01
        ]
    }
    if image == TouhouSiegeEnums.diamond.rawValue {
        return [
            TouhouSiegeStyle.Images.diamond01,
            TouhouSiegeStyle.Images.diamond02,
            TouhouSiegeStyle.Images.diamond03
        ]
    }
    
    if image == TouhouSiegeEnums.gold.rawValue {
        return [
            TouhouSiegeStyle.Images.gold01,
            TouhouSiegeStyle.Images.gold02,
            TouhouSiegeStyle.Images.gold03,
            TouhouSiegeStyle.Images.gold04,
            TouhouSiegeStyle.Images.gold05
        ]
    }
    
    return ["questionmark.circle"]
}

func imageLooping(arrayOfStrings: [String], index: Binding<Int>) -> some View {
    let height = UIScreen.main.bounds.height
    
    return Image(arrayOfStrings[index.wrappedValue])
        .resizable()
        .frame(width: height * 0.06, height: height * 0.06)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                index.wrappedValue = (index.wrappedValue + 1) % arrayOfStrings.count
            }
        }
}

#Preview {
    TopNavBar().environmentObject(UserManager(apiAuthManager: ApiAuthManager())).environmentObject(NavigationManager())
}
