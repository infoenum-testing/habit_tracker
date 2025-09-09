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
                VStack(spacing: 5) {
                    HStack(spacing: 10) {
                        IconBadge(icon: icon, tint: color, height: 50, width: 50)
                            .padding(.leading,10)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                if let title = arc.arcTemplate?.title {
                                    Text(arcFormatted: title)
                                } else {
                                    Text(arcFormatted: "Arc Title")
                                }
                            }

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
                        .padding(.trailing,10)
                    }
                    .frame(height: 70)
                    
                    
                    if state.layout == .grid {
                        let newWidth = (UIScreen.main.bounds.width - 30)
                        let newHeight = newWidth * (45.0 / 187.0)
                        GridTileView(
                            itemType: .arc,
                            values: arc.dailyProgressOpacities,
                            selectedColor: color
                        )
                        .frame(height: newHeight)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 8)
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


