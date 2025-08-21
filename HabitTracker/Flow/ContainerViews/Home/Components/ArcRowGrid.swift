//
//  ArcRowGrid.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//
//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI

struct ArcRowGrid: View {
    let arc: Arc
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 12) {
                    IconBadge(icon: arc.icon, tint: arc.color)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(arc.title)
                            .font(.sfProDisplay(.semibold, size: 19))
                        Text("Day \(arc.dayNumber)")
                            .font(.sfProDisplay(.light, size: 14))
                            .opacity(0.7)
                    }.foregroundStyle(.white)
                    Spacer()
                    CounterPill(text: "\(arc.completedCount)/\(arc.totalCount)", tint: arc.color, completed: arc.completedCount, total: arc.totalCount)
                }
                GridTileView(itemType: .arc, values: arc.history, filledCount: arc.completedArc, selectedColor: arc.color)
                    .frame(height: 100)
            }
            .padding(10)
            .background(arc.color.opacity(0.09))
        }.overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(arc.color.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(arc.color, lineWidth: 1.5))
        )
        .padding(2)
    }
}
