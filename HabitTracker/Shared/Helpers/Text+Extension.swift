//
//  Text+Extension.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 08/09/25.
//

import SwiftUI

extension Text {
    init(arcFormatted string: String, fontSize: CGFloat = 19) {
        if string.hasSuffix("Arc") {
            let baseTitle = String(string.dropLast(3)).trimmingCharacters(in: .whitespaces)
            
            self = Text(baseTitle)
                .font(.sfProDisplay(.semibold, size: fontSize)) +
                Text(" Arc")
                .font(.inter(.mediumItalic, size: fontSize))
        } else {
            self = Text(string)
                .font(.sfProDisplay(.semibold, size: fontSize))
        }
    }
}


import SwiftUI

extension Text {
    init(arcFormatted string: String,
         fontSize: CGFloat = 19,
         arcColor: Color = .red,
         titleColor: Color = .white) {
        
        if string.hasSuffix("Arc") {
            let baseTitle = String(string.dropLast(3)).trimmingCharacters(in: .whitespaces)
            
            self = Text(baseTitle)
                .font(Font.inter(size: fontSize, weight: .medium))
                .foregroundColor(titleColor) +
            Text(" Arc")
                .font(.inter(.mediumItalic, size: fontSize))
                .foregroundColor(arcColor)
        } else {
            self = Text(string)
                .font(.sfProDisplay(.medium, size: fontSize))
                .foregroundColor(titleColor)
        }
    }
}



extension Text {
    init(arcFormattedSelectedText string: String, italicString: String, fontSize: CGFloat = 19) {
        if string.hasSuffix(italicString) {
            let stringcharCount = italicString.count
            let baseTitle = String(string.dropLast(stringcharCount)).trimmingCharacters(in: .whitespaces)
            
            self = Text(baseTitle)
                .font(Font.inter(size: fontSize, weight: .medium)) +
                Text(" \(italicString)")
                .font(.inter(.mediumItalic, size: fontSize))
        } else {
            self = Text(string)
                .font(.sfProDisplay(.semibold, size: fontSize))
        }
    }
}
