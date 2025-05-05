//
//  RegisterView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-03.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiViewModel: ApiViewModel
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    let vm = RegisterViewModel()
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            HStack {
                VStack {
                    CustomTextField(label: "Email", text: $email, fieldStyle: "TextField")
                    
                    CustomTextField(label: "Username", text: $username, fieldStyle: "TextField")
                    
                    CustomTextField(label: "Password", text: $password, fieldStyle: "SecureField")
                    
                    CustomTextField(label: "Repeat Password", text: $repeatPassword, fieldStyle: "SecureField")
                }
                
                VStack {
                    ButtonBig(function: {
                        Task {
                            do {
                                try await apiViewModel.createUser(email: email, username: username, password: password)
                                navigationManager.navigateTo(screen: .landing)
                            } catch let error {
                                print("Error on apitestPOST: \(error)")
                            }
                        }
                    }, text: "Confirm")
                    
                    ButtonBig(function: {
                        navigationManager.navigateTo(screen: .landing)
                    }, text: "Cancel")
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
