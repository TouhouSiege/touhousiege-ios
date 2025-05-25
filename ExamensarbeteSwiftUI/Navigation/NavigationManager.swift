//
//  NavigationLogic.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

/// Enum conditions for paths
enum Screen: Hashable {
    case home
    case landing
    case login
    case game(isComputerPlaying: Bool)
    case gacha
    case about
    case characters
    case shop
    case register
    case settings
    case play
    case defense
    case afterGame(isComputerPlaying: Bool)
}

/// Statenavigation with EnvironmentObject
class NavigationManager: ObservableObject {
    @Published var currentScreen: Screen = .landing
    
    func navigateTo(screen: Screen) {
        currentScreen = screen
    }
    
    /// Retrieves the correct SwiftUI view based on the current screen state.
    func currentView() -> AnyView {
        NavigationScreenManager.viewForScreen(currentScreen)
    }
}


