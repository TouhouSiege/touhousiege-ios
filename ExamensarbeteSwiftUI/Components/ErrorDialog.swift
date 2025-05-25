//
//  ErrorDialog.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-25.
//

import SwiftUI

struct ErrorDialog: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var functionOk: () -> Void
    var title: String
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(TouhouSiegeStyle.FontSize.large.bold())
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                    .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
                
                Spacer()
                
                HStack {
                    ButtonSmall(function: {
                        functionOk()
                    }, text: "Ok")
                }
                .offset(y: -width * TouhouSiegeStyle.Decimals.xSmall)
            }
            .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.small, maxHeight: height * TouhouSiegeStyle.BigDecimals.small)
            .background {
                RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                    .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                    .stroke(Color(TouhouSiegeStyle.Colors.brownLight), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            }
        }
    }
}


