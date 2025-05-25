//
//  MainBackground.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

struct BackgroundMain: View {
    /// .inifinity breaks the bounds and puts the background on top of the zlayer for some reason
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    let title: String
    
    var body: some View {
        ZStack {
            Color.black
            
            Image(TouhouSiegeStyle.Images.bg_general).opacity(TouhouSiegeStyle.BigDecimals.xLarge)
            
            VStack {
                HStack {
                    Text(title)
                        .font(TouhouSiegeStyle.FontSize.ultra.bold())
                        .foregroundStyle(.ultraThinMaterial)
                        .offset(x: width * TouhouSiegeStyle.Decimals.xSmall, y: width * TouhouSiegeStyle.Decimals.xLarge)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .frame(maxWidth: width, maxHeight: height)
        }
        .frame(maxWidth: width, maxHeight: height)
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundMain(title: "")
}
