//
//  LoginView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading = false
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Login")
            
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
                                let _ = try await apiAuthManager.loginUser(email: email, password: password)
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                                    isAnimating = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                                    navigationManager.navigateTo(screen: .landing)
                                })
                            } catch let error {
                                print("Error on login: \(error)")
                            }
                            isLoading = false
                        }
                    }, text: isLoading ? "Logging in..." : "Confirm")
                    ButtonBig(function: {
                        withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                            isAnimating = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                            navigationManager.navigateTo(screen: .landing)
                        })
                    }, text: "Cancel")
                }
            }
            .opacity(isAnimating ? 0 : 1)
        }
        .onAppear {
                isAnimating = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.Decimals.xSmall, execute: {
                    isAnimating = false
                })
        }
        .disabled(isAnimating)
    }
}

#Preview {
    LoginView()
}
