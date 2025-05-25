//
//  CharactersView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    /// Crasches without simplifying
    let characters = Characters.allCharacters
    
    /// To fetch what character to highlight
    @State var selectedCharacter: GameCharacter? = nil
    @State var selectedCharacterId: Int? = nil
    @State var tapAnimation: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Characters")

            HStack {
                Spacer()
                
                if let selectedCharacter = selectedCharacter {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        let fullScreen = UIScreen.main.bounds.size

                        let heightFullCover = fullScreen.height - window.safeAreaInsets.top - window.safeAreaInsets.bottom
                        
                        Image(selectedCharacter.profilePicture.big)
                            .resizable()
                            .scaledToFit()
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: heightFullCover)
                        
                    }
                }
            }
            
            VStack {
                if let selectedCharacter = selectedCharacter {
                    CharacterStatsBanner(statType: "Attack", text: String(selectedCharacter.stats.attack))
                        .offset(x: width * TouhouSiegeStyle.Decimals.xxLarge)
                    CharacterStatsBanner(statType: "Level", text: String(selectedCharacter.stats.level))
                        .offset(x: width * TouhouSiegeStyle.Decimals.medium)
                    CharacterStatsBanner(statType: "Class", text: selectedCharacter.stats.classType.rawValue)
                        .offset(x: width * TouhouSiegeStyle.Decimals.xxLarge)
                    CharacterStatsBanner(statType: "Defense", text: String(selectedCharacter.stats.defense))
                        .offset(x: width * TouhouSiegeStyle.Decimals.large)
                    CharacterStatsBanner(statType: "Health", text: String(selectedCharacter.stats.maxHp))
                        .offset(x: width * TouhouSiegeStyle.Decimals.xxLarge)
                    CharacterStatsBanner(statType: "Speed", text: String(selectedCharacter.stats.speed))
                        .offset(x: width * TouhouSiegeStyle.Decimals.medium)
                }
            }.offset(x: 0, y: width * TouhouSiegeStyle.Decimals.xSmall)
            
            TopNavBar()
            
            VStack {
                HStack {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: width * TouhouSiegeStyle.Decimals.xxLarge + TouhouSiegeStyle.Decimals.xxSmall, maximum: width * TouhouSiegeStyle.Decimals.xxLarge + TouhouSiegeStyle.Decimals.xSmall)), count: 4), spacing: width * TouhouSiegeStyle.Decimals.xxSmall) {
                            ForEach(characters.prefix(5), id: \.name) { character in
                                let characterNotObtained = !(userManager.user?.characters.contains { $0.name == character.name } ?? false)
                                
                                Image(character.profilePicture.small)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: width * TouhouSiegeStyle.Decimals.xxLarge)
                                    .opacity(selectedCharacterId == character.id ? TouhouSiegeStyle.BigDecimals.xxLarge : 1.0)
                                    .onTapGesture {
                                        if let userOwned = userManager.user?.characters.first(where: { $0.name == character.name }) {
                                            selectedCharacter = userOwned
                                        } else {
                                            selectedCharacter = character
                                        }
                                        selectedCharacterId = character.id
                                        withAnimation(.easeInOut(duration: TouhouSiegeStyle.Decimals.xSmall)) {
                                            selectedCharacterId = nil
                                        }
                                    }

                                    .overlay(content: {
                                        Color.black
                                            .opacity(characterNotObtained ? TouhouSiegeStyle.BigDecimals.xLarge : 0.0)
                                    })
                            }
                        }
                    }
                    .frame(maxWidth: ((width * TouhouSiegeStyle.Decimals.xxLarge) * 4) + ((width * TouhouSiegeStyle.Decimals.xxSmall) * 3), maxHeight: width - (width * TouhouSiegeStyle.Decimals.xSmall) - (width * TouhouSiegeStyle.BigDecimals.xSmall))
                    .offset(x: width * TouhouSiegeStyle.Decimals.medium, y: width * TouhouSiegeStyle.Decimals.large + height * TouhouSiegeStyle.BigDecimals.xSmall)
                    
                    Spacer()
                }
                
                Spacer()
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

#Preview {
    CharactersView()
}
