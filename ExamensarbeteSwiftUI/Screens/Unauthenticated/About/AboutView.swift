//
//  AboutView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-03-05.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            VStack {
                Spacer()
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .home)
                }, text: "Back").offset(y: -width * 0.03)
            }
        }
    }
}

#Preview {
    AboutView()
}
