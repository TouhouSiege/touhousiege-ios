//
//  MainBackground.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

struct BackgroundMain: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: width, maxHeight: height)
        .scaledToFill()
        .background(Color.red.opacity(0.2))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundMain()
}
