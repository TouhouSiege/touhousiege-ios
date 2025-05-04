//
//  LoginView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State var email: String = ""
    @State var password: String = ""
    
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
                        navigationManager.navigateTo(screen: .home)
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
    LoginView()
}
