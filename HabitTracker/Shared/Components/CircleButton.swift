//
//  CircleButton.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct CircleButton: View {
    var icon: String
    var action: () -> Void
    var width : CGFloat = 40
    var height: CGFloat = 40

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(icon)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: width, height: height)
        }.buttonStyle(.plain)
    }
}
