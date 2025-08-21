//
//  HabitRowGrid.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//
import Foundation
import SwiftUI

struct HabitRowGrid: View {
    @EnvironmentObject var state: AppState
    let habit: Habit
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                IconBadge(icon: habit.icon, tint: habit.color)
                VStack(alignment: .leading, spacing: 2) {
                    Text(habit.title)
                        .font(.sfProDisplay(.semibold, size: 16))
                    Text(habit.subtitle)
                        .font(.sfProDisplay(.light, size: 14))
                        .opacity(0.7)
                }.foregroundStyle(.white)
                Spacer()
                CheckChip(isOn: state.habits.first(where: { $0.id == habit.id })?.isDone(on: state.selectedDate) ?? false, tint: habit.color) {
                    state.toggleHabit(habit)
                    state.toggleHabitAndUpdateCount(habit)
                }
            }
            GridTileView(itemType: .habit, filledCount: habit.completedCount,selectedColor: habit.color)
                .frame(height: 100)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(UIColor.appDarkGray).opacity(0.8)))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.06), lineWidth: 1))
        .padding(.horizontal, 2)
    }
}
