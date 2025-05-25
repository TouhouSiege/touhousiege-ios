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
                .font(TouhouSiegeStyle.FontSize.large.bold())
                .foregroundStyle(.thinMaterial)
                .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.xSmall, maxHeight: height * TouhouSiegeStyle.BigDecimals.xxSmall)
                .background {
                    RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.large)
                        .fill(Color.brown.opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                        .stroke(.ultraThinMaterial, lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
                }
        })
    }
}

#Preview {
    ButtonBig(function: {
        
    }, text: "Test Text")
}
