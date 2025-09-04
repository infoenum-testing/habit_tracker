//
//  ArcRowList.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct ArcRowList: View {
    @EnvironmentObject var state: AppDataStore
    @EnvironmentObject var swipeManager: SwipeManager
    let arc: SubscribedArc
    let editArcAction: () -> Void
    
    var body: some View {
        let color = ColorToken.from(string: arc.wrappedThemeColor)
        let icon = ColorToken.imageName(from: arc.wrappedThemeColor)
        SwipeableRow(
            id: arc.wrappedId,
                    actions: {
                        Button(action: {
                            print("Edit tapped for \(arc.wrappedTitle)")
                            editArcAction()
                        }) {
                            HStack {
                                Image("editIcon")
                                    .foregroundColor(.black)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading,20)
                                Spacer()
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    },
                    content: {
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        IconBadge(icon: icon, tint: color, height: 48, width: 48)
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(arc.arcTemplate?.title ?? "Arc Title")
                                .font(.sfProDisplay(.semibold, size: 19))
                            Text("Day \(arc.wrappedDurationDays)")
                                .font(.sfProDisplay(.light, size: 14))
                                .opacity(0.7)
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        CounterPill(
                            text: "\(arc.completedTasksToday)/\(arc.wrappedHabitsCount)",
                            tint: color,
                            completed: arc.completedTasksToday,
                            total: arc.wrappedHabitsCount
                        )
                        .padding(.trailing)
                    }
                    .frame(height: 70)
                    
                    
                    if state.layout == .grid {
                        GridTileView(
                            itemType: .arc,
                            values: arc.dailyProgressOpacities,
                            selectedColor: color
                        )
                        .frame(height: 100)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            color.opacity(0.18),
                            color.opacity(0.28),
                            color.opacity(0.38),
                            color.opacity(0.48),
                            color.opacity(0.58),
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .cornerRadius(swipeManager.openRowID == arc.id ? 0 : 14)
                )
                .background(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: swipeManager.openRowID == arc.id ? 0 : 14, style: .continuous)
                        .stroke(color, lineWidth: 1)
                )
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state.layout)
    }
}
