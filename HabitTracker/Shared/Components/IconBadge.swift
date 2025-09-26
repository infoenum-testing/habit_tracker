//
//  IconBadge.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct IconBadge: View {
    var icon: String
    var tint: Color
    var height: CGFloat = 20
    var width: CGFloat = 20
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color.customBlack)
            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(tint)
                .frame(width: width, height: height)
        }
        .frame(width: 42, height: 42)
    }
}
