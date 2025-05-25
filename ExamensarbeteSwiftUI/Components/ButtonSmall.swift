//
//  ButtonSmall.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-19.
//

import SwiftUI

/// Smaller button for game navigating
struct ButtonSmall: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var function: () -> Void
    var text: String
    var image: Image?
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            HStack {
                Text(text)
                    .font(TouhouSiegeStyle.FontSize.small)
                    .foregroundStyle(.thickMaterial)
                
                if let image = image {
                    image
                        .resizable()
                        .frame(width: width * TouhouSiegeStyle.Decimals.xSmall, height: width * TouhouSiegeStyle.Decimals.xSmall)
                }
            }
            .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.xxSmall, maxHeight: height * TouhouSiegeStyle.Decimals.xLarge)
            .background {
                RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                    .fill(Color(TouhouSiegeStyle.Colors.brownLight).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                    .stroke(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.Large), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            }
        })
    }
}


#Preview {
    ButtonSmall(function: {
        
    }, text: "Play")
}
