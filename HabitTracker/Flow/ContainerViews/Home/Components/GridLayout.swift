//
//  GridLayout.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct GridLayout: View {
    @EnvironmentObject var state: AppState
    let columns = [GridItem(.flexible())]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
            ForEach(state.arcs) { arc in
                NavigationLink { ArcDetailView(arcID: arc.id) } label: {
                    ArcRowGrid(arc: arc)
                }
                .buttonStyle(.plain)
            }
            ForEach(state.habits) { habit in
                HabitRowGrid(habit: habit)
            }
        }
        .padding(.top, 8)
            .padding(.bottom, 16) }
    }
}
