//
//  TextFieldNormal.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-04.
//

import SwiftUI

struct CustomTextField: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var label: String
    @State var text: Binding<String>
    var fieldStyle: String
    
    var body: some View {
        switch fieldStyle {
        case "TextField":
            TextField(label, text: text)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .frame(maxWidth: width * 0.2, maxHeight: height * 0.1)
            
        case "SecureField":
            SecureField(label, text: text)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .frame(maxWidth: width * 0.2, maxHeight: height * 0.1)
            
        default:
            Text("Error, Unknown fieldstyle detected!")
        }
    }
}

#Preview {
    CustomTextField(label: "username", text: .constant(""), fieldStyle: "TextField")
}
