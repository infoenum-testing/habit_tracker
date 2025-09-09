//
//  ColorSelectionButton.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation
import SwiftUI

// MARK: - Color Selection Button
 struct ColorSelectionButton: View {
    let color: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorToken.from(string: color))
                .frame(width: 48, height: 48)
                .cornerRadius(19)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
                )
            
            if isSelected {
                Image(StringConstants.Image.check)
                    .resizable()
                    .frame(width: 20, height: 18)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture(perform: onTap)
    }
}
