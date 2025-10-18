//
//  String+Extension.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 08/09/25.
//


import SwiftUI

extension String {
    func withArcItalicized() -> Text {
        if let range = self.range(of: "Arc") {
            let before = String(self[..<range.lowerBound])
            let arc = String(self[range])
            let after = String(self[range.upperBound...])
            
            return Text(before) + Text(arc).italic() + Text(after)
        } else {
            return Text(self)
        }
    }
}


extension String {
    func formattedArcTitle() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else { return "Arc" }

        var corrected = trimmed
        
        // Fix typo "Jumpine" → "Jumping"
        if corrected.lowercased().hasSuffix("ine") {
            corrected = String(corrected.dropLast(3)) + "ing"
        }
        
        // Capitalize first letter
        corrected = corrected.prefix(1).uppercased() + corrected.dropFirst()
        
        // Handle too-short or just "arc"
        if corrected.lowercased() == "arc" || corrected.count < 3 {
            return "Arc"
        }
        
        // Split into words and check if last word is "arc"
        let words = corrected.split(separator: " ")
        if let last = words.last, last.lowercased() == "arc" {
            // Ensure proper casing like "As Arc"
            return words.dropLast().joined(separator: " ") + " Arc"
        }

        // Otherwise, append " Arc"
        return "\(corrected) Arc"
    }
}
