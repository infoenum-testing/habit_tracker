//
//  ColorToken.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
import SwiftUI

enum ColorToken: String, CaseIterable {
    case blue
    case cyan
    case red
    case purple
    case orange
    case green
    case brown
    case black
    case white
    case gray
    
    case maroon
    case navy
    case ice
    case gold
    case indigo
    case teal
    
    var color: Color {
        switch self {
        case .blue: return .appBlue
        case .cyan: return .appCyan
        case .red: return .appRed
        case .purple: return .appPurple
        case .orange: return .appOrange
        case .green: return .appGreen
        case .brown: return .appBrown
        case .black: return .appDarkGray
        case .white: return .appWhite
        case .gray: return .appGray
            
        case .maroon: return .appMaroon
        case .navy: return .appNavy
        case .ice: return .appIce
        case .gold: return .appGold
        case .indigo: return .appIndigo
        case .teal: return .appTeal
            
            
        }
    }
    
    
    var imageName: String {
        switch self {
        case .blue: return "arcBlue"
        case .cyan: return "arcCyan"
        case .red: return "arcRed"
        case .purple: return "arcPurple"
        case .orange: return "arcOrange"
        case .green: return "arcGreen"
        case .brown: return "arcBrown"
        case .black: return "arcBlack"
        case .white: return "arcWhite"
        case .gray: return "arcGray"
        case .maroon:return "arcBeige"
        case .navy:return "arcDarkBlue"
        case .ice:return "arcGray"
        case .gold:return "arcGray"
        case .indigo:return "arcGray"
        case .teal:return "arcGray"
        }
    }
    
    static func from(string: String) -> Color {
        let cleaned = string
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        // take the part after "color."
        let value = cleaned.replacingOccurrences(of: "color.", with: "")
        
        return ColorToken(rawValue: value)?.color ?? .white
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
