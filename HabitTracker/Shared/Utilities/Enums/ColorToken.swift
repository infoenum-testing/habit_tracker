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
    
    var color: Color {
        switch self {
        case .blue: return .appBlue
        case .cyan: return .appCyan
        case .red: return .appRed
        case .purple: return .appPurple
        case .orange: return .appOrange
        case .green: return .appGreen
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
            }
        }
    
    static func from(string: String) -> Color {
        let cleaned = string
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return ColorToken(rawValue: cleaned)?.color ?? .white
    }
    
    static func imageName(from string: String?) -> String {
           guard let string = string else { return "arcGreen" }
           let cleaned = string
               .lowercased()
               .trimmingCharacters(in: .whitespacesAndNewlines)
           return ColorToken(rawValue: cleaned)?.imageName ?? "arcGreen"
       }
}
