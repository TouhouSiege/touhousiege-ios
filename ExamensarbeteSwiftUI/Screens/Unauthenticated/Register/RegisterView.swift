//
//  RegisterView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-03.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var navigationManager: NavigationManager
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
                        //navigationManager.navigateTo(screen: .home)
                        Task {
                            do {
                                try await vm.createUser(email: "Apitest@test.com", username: "Michanapitest", password: "123")
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
