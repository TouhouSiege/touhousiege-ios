//
//  ButtonMedium.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-25.
//

import SwiftUI

/// Medium button for stuff like shop menuing
struct ButtonMedium: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var function: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            Text(text)
                .font(TouhouSiegeStyle.FontSize.medium.bold())
                .foregroundStyle(.thickMaterial)
                .frame(maxWidth: width * (TouhouSiegeStyle.BigDecimals.xxSmall + TouhouSiegeStyle.Decimals.medium), maxHeight: height * TouhouSiegeStyle.BigDecimals.xxSmall)
                .background {
                    RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                        .fill(Color(TouhouSiegeStyle.Colors.brownLight).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                        .stroke(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.Large), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
                }
        })
    }
}

#Preview {
    ButtonMedium(function: {}, text: "gold")
}
