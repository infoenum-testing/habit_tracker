//
//  HabitRowList.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct HabitRowList: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var swipeManager: SwipeManager
    let habit: SubscribedHabit
    let editHabitAction: () -> Void
    var body: some View {
        let color = ColorToken.from(string: habit.wrappedThemeColor)
        SwipeableRow(
            id: habit.wrappedId, actions: {
                Button(action: {
                    print("Edit tapped for \(habit.wrappedTitle)")
                    editHabitAction()
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
                    // Header row (always visible)
                    HStack(spacing: 12) {
                        IconBadge(icon: habit.wrappedIcon, tint: color.opacity(0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.appGray, lineWidth: 1)
                            )
                            .padding(.leading)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(habit.wrappedTitle)
                                .font(.sfProDisplay(.semibold, size: 16))
                            Text(habit.wrappedDetails)
                                .font(.sfProDisplay(.light, size: 14))
                                .opacity(0.7)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.foregroundStyle(.white)
                        
                        Spacer()
                        
                        CheckChip(isOn: habit.isHabitCompleted(habit.wrappedId), tint: color) {
                            
                            guard let subArc = appData.allSubscribedHabits.first(where: { $0.id == habit.wrappedId }) else { return }

                            appData.toggleHabit(habit.wrappedId, in: subArc)
                        }
                        .padding(.trailing)
                        
                    }
                    .frame(height: 70)
                    
                    // Grid view (only visible in grid layout)
                    if state.layout == .grid {
                        GridTileView(itemType: .habit, filledCount: 5, selectedColor: color)
                            .frame(height: 100)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: swipeManager.openRowID == habit.id ? 0 : 14, style: .continuous)
                        .fill(Color(UIColor.black))
                        .overlay(RoundedRectangle(cornerRadius: swipeManager.openRowID == habit.id ? 0 : 14).stroke(Color(UIColor.appGray), lineWidth: 1.5))
                )
                
            })
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state.layout)
    }
}




