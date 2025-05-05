//
//  LoginView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiViewModel: ApiViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            HStack {
                VStack {
                    CustomTextField(label: "Email", text: $email, fieldStyle: "TextField")
                    
                    CustomTextField(label: "Password", text: $password, fieldStyle: "SecureField")
                }
                
                VStack {
                    ButtonBig(function: {
                        Task {
                            isLoading = true
                            do {
                                try await apiViewModel.loginUser(email: email, password: password)
                                navigationManager.navigateTo(screen: .landing)
                            } catch let error {
                                print("Error on login: \(error)")
                            }
                            isLoading = false
                        }
                    }, text: isLoading ? "Logging in..." : "Confirm")
                    ButtonBig(function: {
                        navigationManager.navigateTo(screen: .landing)
                    }, text: "Cancel")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
