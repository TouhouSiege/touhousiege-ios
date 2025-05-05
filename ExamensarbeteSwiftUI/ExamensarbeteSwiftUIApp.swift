//
//  ExamensarbeteSwiftUIApp.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

@main
struct ExamensarbeteSwiftUIApp: App {
    /// Global init of the navigation and ApiViewmodel
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var apiViewModel = ApiViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(navigationManager)
                .environmentObject(apiViewModel)
        }
    }
}
