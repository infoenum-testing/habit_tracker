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
    let arc: Arc
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header row (always visible)
                HStack(spacing: 12) {
                    IconBadge(icon: arc.icon, tint: arc.color)
                        .padding(.leading)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(arc.title)
                            .font(.sfProDisplay(.semibold, size: 19))
                        Text("Day \(arc.dayNumber)")
                            .font(.sfProDisplay(.light, size: 14))
                            .opacity(0.7)
                    }.foregroundStyle(.white)
                    Spacer()
                    CounterPill(text: "\(arc.completedCount)/\(arc.totalCount)", tint: arc.color, completed: arc.completedCount, total: arc.totalCount)
                        .padding(.trailing)
                }
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                
                // Grid view (only visible in grid layout)
                if state.layout == .grid {
                    GridTileView(itemType: .arc, values: arc.history, filledCount: arc.completedArc, selectedColor: arc.color)
                        .frame(height: 100)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        arc.color.opacity(0.2),
                        arc.color.opacity(0.3),
                        arc.color.opacity(0.3),
                        arc.color.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )

            .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(.clear)
                            .overlay(RoundedRectangle(cornerRadius: 14).stroke(arc.color, lineWidth: 0.5))
                    )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state.layout)
            //.border(arc.color, width: 1)
            
            
        }
    }
}
