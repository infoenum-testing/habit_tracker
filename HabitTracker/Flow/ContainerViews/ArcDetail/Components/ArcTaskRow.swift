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
                tint: isCompleted ? .white.opacity(0.4) : .white
            )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.sfProDisplay(.semibold, size: 16))
                    .strikethrough(isCompleted, color: .white.opacity(0.8))
                    .opacity(isCompleted ? 0.4 : 1.0)
                
                Text(task.description)
                    .font(.sfProDisplay(.light, size: 14))
                    .strikethrough(isCompleted, color: .white.opacity(0.8))
                    .opacity(isCompleted ? 0.4 : 0.7)
            }
            .foregroundStyle(.white)
            
            Spacer()
            
            CheckChip(isOn: isCompleted, tint: tint) {
                guard let subArc = appData.allSubscribedArcs.first(where: { $0.id == arc.wrappedId }) else { return }
                appData.toggleArcHabit(taskId, in: subArc)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.customBlack)
        )
        .scaleEffect(isCompleted ? 1.02 : 1.0)
        .animation(
            .spring(response: 0.3, dampingFraction: 0.7),
            value: isCompleted
        )
    }
}
