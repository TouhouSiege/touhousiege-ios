//
//  ExamensarbeteSwiftUIApp.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

@main
struct ExamensarbeteSwiftUIApp: App {
    /// Global init of the navigation
    @StateObject var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(navigationManager)
        }
    }
}
