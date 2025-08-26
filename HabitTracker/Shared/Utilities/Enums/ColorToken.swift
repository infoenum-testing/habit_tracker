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
    
    static func from(string: String) -> Color {
        let cleaned = string
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return ColorToken(rawValue: cleaned)?.color ?? .white // default if not found
    }
}
