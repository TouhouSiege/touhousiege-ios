//
//  HomeScreenViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var text = "I MIGHT CHANGE KEEP TRACK ON ME"
    
    func printTest() {
        print("PRINT FROM VIEWMODEL")
    }
}
