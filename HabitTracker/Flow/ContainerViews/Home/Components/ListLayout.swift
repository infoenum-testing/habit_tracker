//
//  ListLayout.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

//import Foundation
//import SwiftUI
//
//struct ListLayout: View {
//    @EnvironmentObject var state: AppState
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//            VStack(spacing: 12) {
//            // Arc Cards
//            ForEach(state.arcs) { arc in
//                NavigationLink { ArcDetailView(arcID: arc.id) } label: {
//                    ArcRowList(arc: arc, editArcAction: {
//                        
//                    })
//                    .navigationBarHidden(true)
//                }
//                .buttonStyle(.plain)
//            }
//            // Habit Cards
//            ForEach(state.habits) { habit in
//                HabitRowList(habit: habit, editHabitAction: {
//                    
//                })
//            }
//        }
//        .padding(.top, 8)
//        .padding(.bottom, 16)
//        }
//    }
//}
