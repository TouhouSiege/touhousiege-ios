//
//  RegisterView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-03.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var isLoading = false
    @State var isAnimating: Bool = false
    
    let vm = RegisterViewModel()
    
    var body: some View {
        ZStack {
            BackgroundMain(title: "Register")
            
            VStack {
                VStack {
                    CustomTextField(label: "Email", text: $email, fieldStyle: "TextField")
                    
                    CustomTextField(label: "Username", text: $username, fieldStyle: "TextField")
                    
                    CustomTextField(label: "Password", text: $password, fieldStyle: "SecureField")
                    
                    CustomTextField(label: "Repeat Password", text: $repeatPassword, fieldStyle: "SecureField")
                }
                
                VStack {
                    ButtonMedium(function: {
                        Task {
                            isLoading = true
                            do {
                                let _ = try await apiAuthManager.register(email: email, username: username, password: password)
                                withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                                    isAnimating = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                                    navigationManager.navigateTo(screen: .landing)
                                })
                            } catch let error {
                                print("Error on registering: \(error)")
                            }
                            isLoading = false
                        }
                    }, text: isLoading ? "Registering..." : "Confirm")
                    
                    ButtonMedium(function: {
                        withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                            isAnimating = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                            navigationManager.navigateTo(screen: .landing)
                        })
                    }, text: "Cancel")
                }
                .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
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
    RegisterView()
}
