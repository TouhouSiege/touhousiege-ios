//
//  GachaBanner.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-26.
//

import SwiftUI

struct GachaBanner: View {
    /// .inifinity breaks the bounds and puts the background on top of the zlayer for some reason
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    let title: String
    let text: String
    let image: Image
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxLarge))
                .stroke(.ultraThinMaterial, lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            
            HStack {
                Spacer()
                
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: width - (width * 0.5), height: height - (height * 0.4))
                        .offset(x: width * TouhouSiegeStyle.Decimals.large)
                }
            }
            
            VStack {
                HStack {
                    VStack {
                        Text(title)
                            .font(TouhouSiegeStyle.FontSize.large.bold())
                            .foregroundStyle(.thickMaterial)
                        
                        Text(text)
                            .font(TouhouSiegeStyle.FontSize.small)
                            .foregroundStyle(.thinMaterial)
                            .frame(width: (width - (width * 0.7)) / 2)
                        
                        Spacer()
                    }
                    .frame(width: (width - (width * 0.6)) / 2, height: height - (height * 0.4))
                    .offset(x: width * TouhouSiegeStyle.Decimals.xSmall, y: width * TouhouSiegeStyle.Decimals.xSmall)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: width - (width * 0.5), maxHeight: height - (height * 0.4))
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundMain(title: "")
}

