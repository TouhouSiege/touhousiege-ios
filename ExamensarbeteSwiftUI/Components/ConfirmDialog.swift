//
//  ConfirmDialog.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-25.
//

import SwiftUI

struct ConfirmDialog: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var functionYes: () -> Void
    var functionNo: () -> Void
    var title: String
    var buyTitle: String
    var buyText: String
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(TouhouSiegeStyle.FontSize.large.bold())
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                    .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
                
                Spacer()
                
                Text(buyTitle)
                    .font(TouhouSiegeStyle.FontSize.small.bold())
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                
                Text(buyText)
                    .font(TouhouSiegeStyle.FontSize.xSmall)
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                
                Spacer()
                
                HStack {
                    ButtonSmall(function: {
                        functionYes()
                    }, text: "Yes")
                    
                    ButtonSmall(function: {
                        functionNo()
                    }, text: "No")
                }
                .offset(y: -width * TouhouSiegeStyle.Decimals.xSmall)
            }
            .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.medium, maxHeight: height * TouhouSiegeStyle.BigDecimals.medium)
            .background {
                RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                    .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                    .stroke(Color(TouhouSiegeStyle.Colors.brownLight), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            }
        }
    }
}

