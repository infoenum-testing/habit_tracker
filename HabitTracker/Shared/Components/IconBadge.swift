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
    var height: CGFloat = 35
    var width: CGFloat = 35
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(tint)
            Image(icon)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: width, height: height)
        }
        .frame(width: 48, height: 48)
    }
}
