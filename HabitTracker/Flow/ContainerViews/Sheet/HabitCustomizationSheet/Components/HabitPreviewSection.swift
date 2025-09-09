//
//  HabitPreviewSection.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation
import SwiftUI

// MARK: - Habit Preview
struct HabitPreviewSection: View {
    var color: Color
    var icon: String
    var habit: HabitTemplate
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(StringConstants.Sheet.previewHabit)
                .font(Font.sfPro(size: 16, weight: .medium))
                .foregroundColor(.white)
            DailyHabitsCellView(habit: habit, color: color)
        }
    }
}
