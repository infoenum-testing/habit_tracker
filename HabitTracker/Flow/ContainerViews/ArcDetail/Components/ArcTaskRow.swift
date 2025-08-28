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
    let arcID: String
    var task: HabitTemplate
    var isCompleted: Bool
    var tint: Color

    var body: some View {
        HStack(spacing: 12) {
            IconBadge(icon: task.icon ?? "", tint: true ? tint : .appGray)
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title ?? "")
                    .font(.sfProDisplay(.semibold, size: 16))
                Text(task.details ?? "")
                    .font(.sfProDisplay(.light, size: 14))
                    .opacity(0.7)
            }.foregroundStyle(.white)
            Spacer()
            CheckChip(isOn: isCompleted, tint: tint) {
                let habitId = task.id ?? ""
                guard let subArc = appData.allSubscribedArcs.first(where: { $0.id == arcID }) else { return }

                //withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    appData.toggleHabit(habitId, in: subArc)
              //  }
            }

        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(UIColor.appDarkGray)))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.06), lineWidth: 1))
        .scaleEffect(isCompleted ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isCompleted)
    }
}
