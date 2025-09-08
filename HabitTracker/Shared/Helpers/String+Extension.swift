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
