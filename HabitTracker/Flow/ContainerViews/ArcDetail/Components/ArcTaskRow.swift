//
//  ArcTaskRow.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//
import Foundation
import SwiftUI


struct ArcTaskRow: View {
    @EnvironmentObject var appData: AppDataStore
    let arc: SubscribedArc
    let task: HabitData
    var tint: Color

    var body: some View {
        // Precompute expensive values
        let isCompleted = arc.isHabitCompleted(task.id)
        let taskId = task.id

        return HStack(spacing: 12) {
            IconBadge(
                icon: task.icon,
                tint: isCompleted ? tint : .appGray
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.sfProDisplay(.semibold, size: 16))
                Text(task.description)
                    .font(.sfProDisplay(.light, size: 14))
                    .opacity(0.7)
            }
            .foregroundStyle(.white)

            Spacer()

            CheckChip(isOn: isCompleted, tint: tint) {
                guard let subArc = appData.allSubscribedArcs.first(where: { $0.id == arc.wrappedId }) else { return }
                appData.toggleArcHabit(taskId, in: subArc)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(UIColor.appDarkGray))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(.white.opacity(0.06), lineWidth: 1)
        )
        .scaleEffect(isCompleted ? 1.02 : 1.0)
        .animation(
            .spring(response: 0.3, dampingFraction: 0.7),
            value: isCompleted
        )
    }
}
