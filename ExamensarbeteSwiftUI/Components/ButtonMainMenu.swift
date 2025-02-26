//
//  ButtonMainMenu.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

/// Main button for menuing
struct ButtonMainMenu: View {
    var function: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            Text(text)
                .font(.title2)
                .foregroundStyle(.thinMaterial)
                .frame(maxWidth: 300, maxHeight: 50)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.5, green: 0.4, blue: 0.5))
                        .stroke(.thinMaterial, lineWidth: 2)
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 10)
        })
    }
}

#Preview {
    ButtonMainMenu(function: {
        
    }, text: "Test Text")
}
