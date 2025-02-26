//
//  MainBackground.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-01-07.
//

import SwiftUI

struct BackgroundMain: View {
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaledToFill()
        .opacity(0.1)
        .background(Color.red.opacity(0.2))
    }
}

#Preview {
    BackgroundMain()
}
