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
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(tint)
            Image(icon)
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .bold))
                
        }
        .frame(width: 48, height: 48)
    }
}
