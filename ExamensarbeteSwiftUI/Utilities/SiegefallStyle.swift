//
//  SiegefallStyle.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-04-22.
//

import SwiftUI

public class SiegefallStyle {
    struct FontSize {
        static let xSmall = Font.system(size: 10)
        static let small = Font.system(size: 12)
        static let medium = Font.system(size: 14)
        static let xMedium = Font.system(size: 16)
        static let large = Font.system(size: 18)
        static let xLarge = Font.system(size: 20)
    }
    
    struct CornerRadius {
        static let xSmall = CGFloat(2)
        static let small = CGFloat(4)
        static let medium = CGFloat(6)
        static let xMedium = CGFloat(8)
        static let large = CGFloat(10)
        static let xLarge = CGFloat(12)
    }
    
    struct StrokeWidth {
        static let xSmall = CGFloat(1)
        static let small = CGFloat(2)
        static let medium = CGFloat(3)
        static let xMedium = CGFloat(4)
        static let large = CGFloat(5)
        static let xLarge = CGFloat(6)
    }
    
    struct Color {
        static let peachRed = SwiftUI.Color("PeachRed")
    }
}

