//
//  ButtonMainMenu.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

/// Main button for menuing
struct ButtonBig: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var function: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            Text(text)
                .font(SiegefallStyle.FontSize.large)
                .foregroundStyle(.thinMaterial)
                .frame(maxWidth: width * 0.2, maxHeight: height * 0.1)
                .background {
                    RoundedRectangle(cornerRadius: SiegefallStyle.CornerRadius.large)
                        .fill(Color(SiegefallStyle.Color.peachRed))
                        .stroke(.thinMaterial, lineWidth: SiegefallStyle.StrokeWidth.small)
                }
        })
    }
}

#Preview {
    ButtonBig(function: {
        
    }, text: "Test Text")
}
