//
//  NavigationLogic.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

/// Enum conditions to handle the different navigation paths.
enum Screen {
    case home
    case landing
    case login
    case game
    case markdownsaur
    case gacha
    case purchaseCrystal
    case about
    case characters
}

/// Handles navigation state.
class NavigationManager: ObservableObject {
    @Published var currentScreen: Screen = .landing

    /// Enables navigation to other screens.
    func navigate(to screen: Screen) {
        withAnimation {
            currentScreen = screen
        }
    }

    /// Function that returns a screen based on the current view.
    func getCurrentView() -> AnyView {
        switch currentScreen {
        case .home:
            print("TO HOMESCREEN")
            return AnyView(HomeView())
        case .game:
            print("TO LOGGEDINLANDINGPAGE")
            return AnyView(GameView())
        case .login:
            print("TO LOGINSCREEN")
            return AnyView(LoginView())
        case .markdownsaur:
            print("TO MARKDOWNTEST")
            return AnyView(MarkdownView())
        case .landing:
            print("TO LANDING PAGE")
            return AnyView(LandingView())
        case .gacha:
            print("TO GACHA PAGE")
            return AnyView(GachaView())
        case .purchaseCrystal:
            print("TO PURCHASE CRYSTAL PAGE")
            return AnyView(PurchaseCrystalView())
        case .about:
            print("TO ABOUT US PAGE")
            return AnyView(AboutView())
        case .characters:
            print("TO CHARACTERS PAGE")
            return AnyView(CharactersView())
        }
    }
}

