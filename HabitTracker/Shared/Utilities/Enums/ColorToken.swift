//
//  ColorToken.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 26/08/25.
//
import SwiftUI

enum ColorToken: String, CaseIterable {
    case blue
    case red
    case purple
    case orange
    case green
    case gold
    case cyan
    case grey
    case pink
    case beige
    case darkblue
    case yellow

    
    var color: Color {
        switch self {
        case .blue: return .appBlue
        case .red: return .appRed
        case .purple: return .appPurple
        case .orange: return .appOrange
        case .green: return .appGreen
        case .gold: return .appGold
        case .cyan: return .appCyan
        case .grey: return .appLightGrey
        case .pink: return .appPink
        case .beige: return .appBeige
        case .darkblue: return .appDarkBlue
        case .yellow: return .appYellow
        }
    }
    
    var colorGradient : [Color] {
        switch self {
        case .blue: return [.gradientBlueLight, .gradientBlueDark]
        case .red:
            return [.gradientRedLight, .gradientRedDark]
        case .purple:
            return [.gradientPurpleLight, .gradientPurpleDark]
        case .orange:
            return [.gradientOrangeLight, .gradientOrangeDark]
        case .green:
            return [.gradientGreenLight, .gradientGreenDark]
        case .gold:
            return [.gradientGoldLight, .gradientGoldDark]
        
        case .cyan:
            return [.gradientCyanLight, .gradientCyanDark]
        case .grey:
            return [.gradientGrayLight, .gradientGrayDark]

        case .pink:
            return [.gradientPinkLight, .gradientPinkDark]

        case .beige:
            return [.gradientBeigeLight, .gradientBeigeDark]

        case .darkblue:
            return [.gradientDarkBlueLight, .gradientDarkBlueDark]

        case .yellow:
            return [.gradientYellowLight, .gradientYellowDark]
        }
    }
    
    var imageName: String {
        switch self {
        case .blue: return "arcBlue"
        case .red: return "arcRed"
        case .purple: return "arcPurple"
        case .orange: return "arcOrange"
        case .green: return "arcGreen"
        case .gold: return "arcGold"
        case .cyan: return "arcCyan"
        case .grey: return "arcGray"
        case .pink: return "arcPink"
        case .beige: return "arcBeige"
        case .darkblue: return "arcDarkBlue"
        case .yellow: return "arcYellow"
        }
    }
    
    static func from(string: String) -> Color {
        let cleaned = string
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let value = cleaned.replacingOccurrences(of: "color.", with: "")
        return ColorToken(rawValue: value)?.color ?? .white
    }
    
    static func returnGradientColors(string: String) -> [Color] {
        let cleaned = string
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let value = cleaned.replacingOccurrences(of: "color.", with: "")
        return ColorToken(rawValue: value)?.colorGradient ?? [.white,.white]
    }
    
    
    static func imageName(from string: String?) -> String {
        guard let string = string else { return "arcGreen" }
        let cleaned = string
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let value = cleaned.replacingOccurrences(of: "color.", with: "")
        return ColorToken(rawValue: value)?.imageName ?? "arcGreen"
    }
}
