//
//  CharacterStatsBanner.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-20.
//

import SwiftUI

struct CharacterStatsBanner: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var statType: String
    var text: String
    
    var body: some View {
        VStack {
            Text(statType)
                .font(TouhouSiegeStyle.FontSize.xSmall.bold())
                .foregroundStyle(.thinMaterial)
            Text(text)
                .font(TouhouSiegeStyle.FontSize.medium)
                .foregroundStyle(.ultraThickMaterial)
        }
        .frame(width: width * TouhouSiegeStyle.Decimals.xxLarge, height: height * TouhouSiegeStyle.Decimals.large)
        .padding(width * TouhouSiegeStyle.Decimals.xxSmall)
        .background {
            RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.large)
                .fill(Color(TouhouSiegeStyle.Colors.peachRed))
                .stroke(.thinMaterial, lineWidth: TouhouSiegeStyle.StrokeWidth.small)
        }
    }
}

#Preview {
    CharacterStatsBanner(statType: "Attack", text: "30")
}
