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
    
    struct Decimals {
        static let xxSmall = CGFloat(0.01)
        static let xSmall = CGFloat(0.02)
        static let small = CGFloat(0.03)
        static let medium = CGFloat(0.04)
        static let xMedium = CGFloat(0.05)
        static let large = CGFloat(0.06)
        static let xLarge = CGFloat(0.07)
        static let xxLarge = CGFloat(0.08)
    }
    
    struct BigDecimals {
        static let xxSmall = CGFloat(0.1)
        static let xSmall = CGFloat(0.2)
        static let small = CGFloat(0.3)
        static let medium = CGFloat(0.4)
        static let xMedium = CGFloat(0.5)
        static let Large = CGFloat(0.6)
        static let xLarge = CGFloat(0.7)
        static let xxLarge = CGFloat(0.8)
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
        
        static let bg_play: [String] = (1...8).map { "bg_play_\($0)" }
        
        static let reimuHakureiProfileSmall = "reimu_hakurei_profile"
        static let reimuHakureiProfileLarge = "reimu_hakurei_profile_big"
        static let reimuHakureiIdle: [String] = (1...14).map { "reimu_hakurei_idle_\($0)" }
        static let reimuHakureiAttack: [String] = (1...11).map { "reimu_hakurei_attack_\($0)"}
        static let reimuHakureiFaint: [String] = (1...9).map { "reimu_hakurei_faint_\($0)"}
        static let reimuHakureiMoveForward: [String] = (1...10).map { "reimu_hakurei_move_forward_\($0)"}
        static let reimuHakureiMoveBackwards: [String] = (1...10).map { "reimu_hakurei_move_backwards_\($0)"}
        static let reimuHakureiGetHit: [String] = (1...8).map { "reimu_hakurei_get_hit_\($0)"}
        
        static let hijiriByakurenProfileSmall = "hijiri_byakuren_profile"
        static let hijiriByakurenProfileLarge = "hijiri_byakuren_profile_big"
        static let hijiriByakurenIdle: [String] = (1...14).map { "hijiri_byakuren_idle_\($0)" }
        static let hijiriByakurenAttack: [String] = (1...10).map { "hijiri_byakuren_attack_\($0)"}
        static let hijiriByakurenFaint: [String] = (1...8).map { "hijiri_byakuren_faint_\($0)"}
        static let hijiriByakurenMoveForward: [String] = (1...13).map { "hijiri_byakuren_move_forward_\($0)"}
        static let hijiriByakurenMoveBackwards: [String] = (1...10).map { "hijiri_byakuren_move_backwards_\($0)"}
        static let hijiriByakurenGetHit: [String] = (1...5).map { "hijiri_byakuren_get_hit_\($0)"}
        
        static let tenshiHinanawiProfileSmall = "tenshi_hinanawi_profile"
        static let tenshiHinanawiProfileLarge = "tenshi_hinanawi_profile_big"
        static let tenshiHinanawiIdle: [String] = (1...10).map { "tenshi_hinanawi_idle_\($0)" }
        static let tenshiHinanawiAttack: [String] = (1...10).map { "tenshi_hinanawi_attack_\($0)"}
        static let tenshiHinanawiFaint: [String] = (1...11).map { "tenshi_hinanawi_faint_\($0)"}
        static let tenshiHinanawiMoveForward: [String] = (1...13).map { "tenshi_hinanawi_move_forward_\($0)"}
        static let tenshiHinanawiMoveBackwards: [String] = (1...9).map { "tenshi_hinanawi_move_backwards_\($0)"}
        static let tenshiHinanawiGetHit: [String] = (1...4).map { "tenshi_hinanawi_get_hit_\($0)"}
        
        static let koishiKomeijiProfileSmall = "koishi_komeiji_profile"
        static let koishiKomeijiProfileLarge = "koishi_komeiji_profile_big"
        static let koishiKomeijiIdle: [String] = (1...12).map { "koishi_komeiji_idle_\($0)" }
        static let koishiKomeijiAttack: [String] = (1...7).map { "koishi_komeiji_attack_\($0)"}
        static let koishiKomeijiFaint: [String] = (1...10).map { "koishi_komeiji_faint_\($0)"}
        static let koishiKomeijiMoveForward: [String] = (1...8).map { "koishi_komeiji_move_forward_\($0)"}
        static let koishiKomeijiMoveBackwards: [String] = (1...10).map { "koishi_komeiji_move_backwards_\($0)"}
        static let koishiKomeijiGetHit: [String] = (1...5).map { "koishi_komeiji_get_hit_\($0)"}
        
        static let reisenUdongeinInabaProfileSmall = "reisen_udongein_inaba_profile"
        static let reisenUdongeinInabaProfileLarge = "reisen_udongein_inaba_profile_big"
        static let reisenUdongeinInabaIdle: [String] = (1...14).map { "reisen_udongein_inaba_idle_\($0)" }
        static let reisenUdongeinInabaAttack: [String] = (1...11).map { "reisen_udongein_inaba_attack_\($0)"}
        static let reisenUdongeinInabaFaint: [String] = (1...6).map { "reisen_udongein_inaba_faint_\($0)"}
        static let reisenUdongeinInabaMoveForward: [String] = (1...9).map { "reisen_udongein_inaba_move_forward_\($0)"}
        static let reisenUdongeinInabaMoveBackwards: [String] = (1...9).map { "reisen_udongein_inaba_move_backwards_\($0)"}
        static let reisenUdongeinInabaGetHit: [String] = (1...4).map { "reisen_udongein_inaba_get_hit_\($0)"}
    }
}


