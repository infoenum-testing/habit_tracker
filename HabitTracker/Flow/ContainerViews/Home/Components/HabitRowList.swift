//
//  HabitRowList.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

//struct HabitRowList: View {
//    @EnvironmentObject var state: AppState
//    @EnvironmentObject var swipeManager: SwipeManager
//    let habit: Habit
//    let editHabitAction: () -> Void
//    var body: some View {
//        
//        SwipeableRow(
//            id: habit.id, actions: {
//                Button(action: {
//                    print("Edit tapped for \(habit.title)")
//                    editHabitAction()
//                }) {
//                    HStack {
//                        Image("editIcon")
//                            .foregroundColor(.black)
//                            .frame(width: 30, height: 30)
//                            .padding(.leading,20)
//                        Spacer()
//                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
//                }
//            },
//            content: {
//                VStack(spacing: 0) {
//                    // Header row (always visible)
//                    HStack(spacing: 12) {
//                        IconBadge(icon: habit.icon, tint: habit.color.opacity(0.3))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.appGray, lineWidth: 1)
//                            )
//                            .padding(.leading)
//                        VStack(alignment: .leading, spacing: 2) {
//                            Text(habit.title)
//                                .font(.sfProDisplay(.semibold, size: 16))
//                            Text(habit.subtitle)
//                                .font(.sfProDisplay(.light, size: 14))
//                                .opacity(0.7)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }.foregroundStyle(.white)
//                        
//                        Spacer()
//                        CheckChip(isOn: state.habits.first(where: { $0.id == habit.id })?.isDone(on: state.selectedDate) ?? false, tint: habit.color) {
//                            state.toggleHabit(habit)
//                            state.toggleHabitAndUpdateCount(habit)
//                        }
//                        .padding(.trailing)
//                    }
//                    .frame(height: 70)
//                    
//                    // Grid view (only visible in grid layout)
//                    if state.layout == .grid {
//                        GridTileView(itemType: .habit, filledCount: habit.completedCount, selectedColor: habit.color)
//                            .frame(height: 100)
//                            .padding(.horizontal, 10)
//                            .padding(.bottom, 10)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//                .background(
//                    RoundedRectangle(cornerRadius: swipeManager.openRowID == habit.id ? 0 : 14, style: .continuous)
//                        .fill(Color(UIColor.black))
//                        .overlay(RoundedRectangle(cornerRadius: swipeManager.openRowID == habit.id ? 0 : 14).stroke(Color(UIColor.appGray), lineWidth: 1.5))
//                )
//                
//            })
//        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state.layout)
//    }
//}




