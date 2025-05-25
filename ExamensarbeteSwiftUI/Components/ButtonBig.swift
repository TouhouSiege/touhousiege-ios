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
                .foregroundStyle(.thickMaterial)
                .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.xSmall, maxHeight: height * TouhouSiegeStyle.BigDecimals.xxSmall)
                .background {
                    RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                        .fill(Color(TouhouSiegeStyle.Colors.brownLight).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                        .stroke(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.Large), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
                }
        })
    }
}

#Preview {
    ButtonBig(function: {
        
    }, text: "Test Text")
}
