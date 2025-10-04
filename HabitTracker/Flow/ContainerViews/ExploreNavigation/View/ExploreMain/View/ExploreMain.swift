//
//  ExploreMain.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 22/08/25.
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
            VStack(alignment: .leading){
                headerView
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color.navBackground)
            DashedLine()
            
            // MARK: - Scroll Content
                ScrollView {
                    VStack(spacing: 25) {
                        
                        if  !appData.allArcs.isEmpty {
                            HStack(spacing: 10) {
                                Button {
                                    router.push(to: .allArcsView(title: ""))
                                } label: {
                                    ArcsView(isArc: true)
                                }
                                
                                Button {
                                    router.push(to: .allHabitsView)
                                } label: {
                                    ArcsView(isArc: false)
                                }
                            }
                        }
                        DashedLine()
                        ExploreSection(
                            title: StringConstants.ExploreNavigation.trendingArcs,
                            columns: columns,
                            onViewAll: { router.push(to: .allArcsView(title: "")) },
                            isHabitSection: false,
                            selectedHabit: $selectedHabit
                        )
                        ExploreSection(
                            title: StringConstants.ExploreNavigation.trendingHabits,
                            columns: columns,
                            onViewAll: { router.push(to: .allHabitsView) },
                            isHabitSection: true,
                            
                            selectedHabit: $selectedHabit
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.sheetBackgroundColor.ignoresSafeArea())
        .sheet(item: $selectedHabit) { habit in
            HabitCustomizationSheet(habit: habit)
                .presentationDetents([.large])
            //.presentationDragIndicator(.visible)
                .presentationCornerRadius(45)
        }
    }
}

// MARK: - Header
private extension ExploreMain {
    var headerView: some View {
        VStack(spacing: 20) {
            Text(StringConstants.ExploreNavigation.explore)
                .font(Font.inter(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .top)
            
            HStack {
                Image( StringConstants.Image.magnifyingGlass)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                
                Spacer()
                
                Image(StringConstants.Image.cancelIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.searchBarColur)
            .cornerRadius(17)
        }
    }
}

#Preview {
    ExploreMain()
}
