//
//  MainView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

/// Main View where all views are pushed into to be shown.
struct MainView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        NavigationScreenManager.viewForScreen(navigationManager.currentScreen)
    }
}

#Preview {
    MainView().environmentObject(NavigationManager())
}
