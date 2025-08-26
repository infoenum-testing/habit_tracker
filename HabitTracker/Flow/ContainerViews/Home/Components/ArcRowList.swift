//
//  ArcRowList.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct ArcRowList: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var swipeManager: SwipeManager

    let arc: Arc
    
    var body: some View {
        SwipeableRow(
                    id: arc.id,
                    actions: {
                        HStack {
                            Image("editIcon")
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                                .padding(.leading,20)
                            Spacer()
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    },
                    content: {
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        IconBadge(icon: arc.icon, tint: arc.color)
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(arc.title)
                                .font(.sfProDisplay(.semibold, size: 19))
                            Text("Day \(arc.dayNumber)")
                                .font(.sfProDisplay(.light, size: 14))
                                .opacity(0.7)
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        CounterPill(
                            text: "\(arc.completedCount)/\(arc.totalCount)",
                            tint: arc.color,
                            completed: arc.completedCount,
                            total: arc.totalCount
                        )
                        .padding(.trailing)
                    }
                    .frame(height: 70)
                    
                    
                    if state.layout == .grid {
                        GridTileView(itemType: .arc,
                                     values: arc.history,
                                     filledCount: arc.completedArc,
                                     selectedColor: arc.color)
                        .frame(height: 100)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            arc.color.opacity(0.18),
                            arc.color.opacity(0.28),
                            arc.color.opacity(0.38),
                            arc.color.opacity(0.48)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .cornerRadius(swipeManager.openRowID == arc.id ? 0 : 14)
                )
                .background(.black)
               
                .overlay(
                    RoundedRectangle(cornerRadius: swipeManager.openRowID == arc.id ? 0 : 14, style: .continuous)
                        .stroke(arc.color, lineWidth: 1)
                )
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state.layout)
    }
}
