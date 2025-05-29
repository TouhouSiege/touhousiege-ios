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
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var email: String = "superdude@gmail.com"
    @State var password: String = "123"
    @State var isLoading = false
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Login")
            
            VStack {
                VStack {
                    CustomTextField(label: "Email", text: $email, fieldStyle: "TextField")
                    
                    CustomTextField(label: "Password", text: $password, fieldStyle: "SecureField")
                }
                
                VStack {
                    ButtonMedium(function: {
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
                    
                    ButtonMedium(function: {
                        withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                            isAnimating = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                            navigationManager.navigateTo(screen: .landing)
                        })
                    }, text: "Cancel")
                }
                .offset(y: width * TouhouSiegeStyle.Decimals.medium)
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
