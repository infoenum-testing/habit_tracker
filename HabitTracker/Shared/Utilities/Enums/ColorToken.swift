//
//  ColorToken.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
import SwiftUI

enum ColorToken: String, CaseIterable {
    case blue
    case red
    case purple
    case orange
    case green
    case brown
    case black
    case white
    case gray
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
        case .brown: return .appBrown
        case .black: return .appDarkGray
        case .white: return .appWhite
        case .gray: return .appGray
        case .pink: return .appPink
        case .beige: return .appBeige
        case .darkblue: return .appDarkBlue
        case .yellow: return .appYellow
        }
    }
    
    
    var imageName: String {
        switch self {
        case .blue: return "arcBlue"
        case .red: return "arcRed"
        case .purple: return "arcPurple"
        case .orange: return "arcOrange"
        case .green: return "arcGreen"
        case .brown: return "arcBrown"
        case .black: return "arcBlack"
        case .white: return "arcWhite"
        case .gray: return "arcGray"
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
