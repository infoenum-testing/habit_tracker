//
//  ColorPickerSection.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation
import SwiftUI

// MARK: - Color Picker
 struct ColorPickerSection: View {
    let colors: [String]
    @Binding var selectedColor: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text(StringConstants.Sheet.changeTheme)
                .font(Font.sfPro(size: 17, weight: .medium))
                .foregroundColor(.white)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 6), spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    ColorSelectionButton(
                        color: color,
                        isSelected: color == selectedColor
                    ) {
                        selectedColor = color
                        action()
                    }
                }
            }
        }
    }
}
