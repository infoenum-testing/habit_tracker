//
//  ExploreMain.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI
struct ExploreMain: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    @State private var selectedHabit: HabitTemplate?
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Header
            headerView
                .padding(.horizontal, 28)
                .padding(.bottom, 24)
            
            // MARK: - Scroll Content
            ScrollView {
                VStack(spacing: 32) {
                    ExploreSection(
                        title: "Trending Arcs",
                        columns: columns,
                        onViewAll: { router.push(to: .allArcsView) },
                        isHabitSection: false,
                        selectedHabit: $selectedHabit
                    )
                    
                    ExploreSection(
                        title: "Trending Habits",
                        columns: columns,
                        onViewAll: { router.push(to: .allHabitsView) },
                        isHabitSection: true,
                        
                        selectedHabit: $selectedHabit
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .padding(.top, 72)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black)
        .ignoresSafeArea()
        .sheet(item: $selectedHabit) { habit in
            
            HabitCustomizationSheet(habit: habit)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(45)
            
        }
    }
}

// MARK: - Header
private extension ExploreMain {
    var headerView: some View {
        VStack(spacing: 20) {
            Text("Explore")
                .font(Font.inter(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .top)
            
            HStack {
                Image("magnifying-glass-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                
                Spacer()
                
                Image("Vector")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.1))
            .cornerRadius(17)
        }
    }
}

// MARK: - Section Component
struct ExploreSection: View {
    let title: String
    let columns: [GridItem]
    let onViewAll: () -> Void
    var isHabitSection: Bool
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var router: NavigationRouter
    @Binding var selectedHabit: HabitTemplate?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text(title)
                    .font(Font.sfPro(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    onViewAll()
                } label: {
                    HStack(spacing: 2) {
                        Text("View All")
                            .font(Font.sfPro(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Image("chevron-right-small")
                            .frame(width: 28, height: 28)
                    }
                }
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                
                if isHabitSection {
                    ForEach(appData.allHabits, id: \.id) { habit in
                        HabitCardCellView(habit: habit) {
                            selectedHabit = habit
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                } else {
                    ForEach(appData.allArcs, id: \.id) { arc in
                        ArcCardCell(arc: arc){
                            router.push(to: .arcDetailPreJoinView(arcTemplate: arc))
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
}


#Preview {
    ExploreMain()
}
