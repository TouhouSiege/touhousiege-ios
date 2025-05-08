//
//  SiegefallStyle.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-04-22.
//

import SwiftUI

public class TouhouSiegeStyle {
    enum FontSize {
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
    
    struct Colors {
        static let peachRed = Color("PeachRed")
    }
    
    struct Images {
        static let stamina01 = "stamina_01"
        
        static let diamond01 = "diamond_01"
        static let diamond02 = "diamond_02"
        static let diamond03 = "diamond_03"
        
        static let gold01 = "goldcoin_01"
        static let gold02 = "goldcoin_02"
        static let gold03 = "goldcoin_03"
        static let gold04 = "goldcoin_04"
        static let gold05 = "goldcoin_05"
        
        static let reimuHakureiProfile = "reimu_hakurei_profile"
        static let reimuHakureiIdle: [String] = (1...14).map { "reimu_hakurei_idle_\($0)" }
        
        static let hijiriByakurenProfile = "hijiri_byakuren_profile"
        static let hijiriByakurenIdle: [String] = (1...14).map { "hijiri_byakuren_idle_\($0)" }
        
        static let tenshiHinanawiProfile = "tenshi_hinanawi_profile"
        static let tenshiHinanawiIdle: [String] = (1...10).map { "tenshi_hinanawi_idle_\($0)" }
        
    }
}


