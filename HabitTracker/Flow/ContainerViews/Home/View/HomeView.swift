//
//  HomeScreen.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var state: AppState
    @State private var selectedArc: Arc? = nil
    @State private var showArcDetail = false

    var body: some View {
       // NavigationStack {
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
                                NavigationLink { ArcDetailView(arcID: arc.id) } label: {
                                    ArcRowList(arc: arc)
//                                        .onTapGesture(perform: {
//                                            selectedArc = arc
//                                            showArcDetail = true
//                                        })
                                        .navigationBarHidden(true)
                                }
                                .buttonStyle(.plain)
                            }
                            // Habit Cards
                            ForEach(state.habits) { habit in
                                HabitRowList(habit: habit)
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 20)
                    }
                }
                
            }
            .toolbar(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .navigationBarHidden(true)
            
            
            .sheet(isPresented: $showArcDetail) {
                if let arc = selectedArc {
                    NavigationStack {
                        ArcDetailView(arcID: arc.id)
                            .navigationBarHidden(true)
                    }
                    .presentationDetents([.large])
                    .presentationCornerRadius(24)
                    //.presentationDragIndicator(.visible)
                }
            }

       // }.navigationBarHidden(true)
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
