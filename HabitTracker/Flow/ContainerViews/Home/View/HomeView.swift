//
//  HomeScreen.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var swipeManager = SwipeManager()


    var body: some View {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    HomeHeader()
                        .padding(.top, 6)
                        .padding(.horizontal,20)
                        DateStrip()
                            .padding(.top, 4)
                    Text("Todays Tasks")
                        .font(.sfProDisplay(.medium, size: 17))
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal,20)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            // Arc Cards
                            ForEach(state.arcs) { arc in
                                    ArcRowList(arc: arc)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            swipeManager.closeAll()
                                        }
                                        router.push(to: Route.arcDetail(id: arc.id))
                                    }
                            }
                            // Habit Cards
                            ForEach(state.habits) { habit in
                                HabitRowList(habit: habit)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            swipeManager.closeAll()
                                        }
                                    }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 20)
                    }  .environmentObject(swipeManager)
                }
            }
            .toolbar(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .navigationBarHidden(true)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
        .environmentObject(
            AppState(arcs: MockData.arcs, habits: MockData.habits)
        )
        .preferredColorScheme(.dark)
}
