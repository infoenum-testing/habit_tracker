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
                .font(.openSans(.semiboldItalic, size: fontSize))
        } else {
            self = Text(string)
                .font(.sfProDisplay(.semibold, size: fontSize))
        }
    }
}
