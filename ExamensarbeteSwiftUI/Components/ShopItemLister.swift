//
//  ShopItemLister.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-25.
//

import SwiftUI

struct ShopItemLister: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var function: () -> Void
    var titel: String
    var text: String
    var cost: String
    var imageButton: Image?
    var imageBigIcon: Image?
    
    var body: some View {
        VStack {
            Text(titel)
                .font(TouhouSiegeStyle.FontSize.xMedium.bold())
                .foregroundStyle(.thickMaterial)
                .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
            
            Text(text)
                .font(TouhouSiegeStyle.FontSize.small)
                .foregroundStyle(.thinMaterial)
                .offset(y: width * TouhouSiegeStyle.Decimals.small)
            
            Spacer()
            
            if let image = imageBigIcon {
                image
                    .resizable()
                    .frame(width: width * TouhouSiegeStyle.Decimals.medium, height: width * TouhouSiegeStyle.Decimals.medium)
            }
            
            Spacer()
            
            ButtonSmall(function: {
                function()
            }, text: cost, image: imageButton)
            .offset(y: -width * TouhouSiegeStyle.Decimals.xSmall)
        }
        .frame(maxWidth: width * 0.2, maxHeight: width * 0.25)
        
        .background {
            RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxLarge))
                .stroke(.ultraThinMaterial, lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
                
            
        }
    }
}
