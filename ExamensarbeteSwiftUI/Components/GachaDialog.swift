//
//  GachaDialog.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-26.
//

import SwiftUI

struct GachaDialog: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var functionOk: () -> Void
    var title: String
    var text: String
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(TouhouSiegeStyle.FontSize.large.bold())
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                    .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
                
                Spacer()
                
                Text(text)
                    .font(TouhouSiegeStyle.FontSize.xSmall)
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                
                Spacer()
                
                HStack {
                    ButtonSmall(function: {
                        functionOk()
                    }, text: "Ok")
                }
                .offset(y: -width * TouhouSiegeStyle.Decimals.xSmall)
            }
            .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.small, maxHeight: height * TouhouSiegeStyle.BigDecimals.Large)
            .background {
                RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                    .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                    .stroke(Color(TouhouSiegeStyle.Colors.brownLight), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            }
        }
    }
}

#Preview {
    GachaDialog(functionOk: {}, title: "", text: "")
}
