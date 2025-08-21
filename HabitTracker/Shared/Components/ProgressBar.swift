//
//  ProgressBar.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct ProgressBar: View { var progress: Double; var tint: Color; var body: some View {
    GeometryReader { geo in
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6).fill(.white.opacity(0.08))
            RoundedRectangle(cornerRadius: 6)
                .fill(tint)
                .frame(width: geo.size.width * progress)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: progress)
        }
    }
}}
