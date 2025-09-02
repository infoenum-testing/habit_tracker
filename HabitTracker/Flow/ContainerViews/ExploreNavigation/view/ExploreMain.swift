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
            VStack(alignment: .leading){
                headerView
            }
            .padding(.horizontal, 28)
            .padding(.top, 72)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color.navBackground)
            DashedLine()
            
            
            
            
            
            // MARK: - Scroll Content
            ScrollView {
                VStack(spacing: 27) {
                    
                    HStack(spacing: 10) {
                        ArcsView(isArc: true)
                        ArcsView(isArc: false)
                    }.frame(maxWidth: .infinity)
                    
                    DashedLine()
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
                .padding(.vertical, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.sheetBackgroundColor)
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
            .background(Color.searchBarColur)
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
                    ForEach(appData.allHabits.prefix(4), id: \.id) { habit in
                        HabitCardCellView(habit: habit) {
                            selectedHabit = habit
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                } else {
                    ForEach(appData.allArcs.prefix(4), id: \.id) { arc in
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

struct ArcsView: View {
    
    @EnvironmentObject var appData: AppDataStore
    var isArc: Bool
    
    var body: some View {
        ZStack {
            // Background with corner radius + gradient
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                    stops: [
                    Gradient.Stop(color: Color(red: 0.21, green: 0.22, blue: 0.23), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.58, green: 0.6, blue: 0.63).opacity(0.75), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1.04)
                    )
                )
                .shadow(radius: 8)
            
            VStack(spacing: 5) {
                // Title
                HStack {
                    Text(isArc ? "Arcs" : "Habbits")
                        .foregroundColor(.white)
                        .font(Font.sfPro(size: 23, weight: .medium))
                        .padding(.leading)
                    
                    if isArc {
                        Image("arc")
                            .resizable()
                            .frame(width: 16,height: 16)
                    }
                    
                    Spacer()
                }
                ZStack {
                    if isArc {
                        let arcs = Array(appData.allArcs.prefix(2).enumerated())
                        ForEach(arcs, id: \.offset) { index, element in
                            let arc = element
                            arcCardView(arc: arc, index: index)
                        }
                    } else {
                        let habits = Array(appData.allHabits.prefix(2).enumerated())
                        ForEach(habits, id: \.offset) { index, element in
                            let habit = element
                            habitCardView(habit: habit, index: index)
                        }
                    }
                }
            }
            .padding(.top)
        }.clipped()
    }
    
    private func arcCardView(arc: ArcTemplate, index: Int) -> some View {
            TopArcCardView(
                title: arc.title ?? "",
                subtitle: arc.descriptionText ?? "",
                days: "\(arc.durationDays)",
                habits: "\(arc.habits?.count ?? 0)",
                imageName: "card"
            )
            .rotationEffect(.degrees(index == 0 ? -8 : 12))
            .offset(x: index == 0 ? -25 : 35, y: index == 0 ? 5 : -2)
        }
        
        private func habitCardView(habit: HabitTemplate, index: Int) -> some View {
            TopArcCardView(
                title: habit.title ?? "",
                subtitle: habit.details ?? "",
                days: "",
                habits: "",
                imageName: habit.icon ?? ""
            )
            .rotationEffect(.degrees(index == 0 ? -8 : 12))
            .offset(x: index == 0 ? -25 : 35, y: index == 0 ? 5 : -2)
        }
}

struct TopArcCardView: View {
    var title: String
    var subtitle: String
    var days: String
    var habits: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 85)
                .clipped()
               // .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            // Overlay content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("\(days) Days")
                        .foregroundColor(.white)
                        .font(Font.inter(size: 3))
                        .padding(.horizontal, 3)
                        .padding(.vertical, 2)
                        .background(Color.black.opacity(0.75))
                        .cornerRadius(5)
                        .fixedSize(horizontal: true, vertical: false)
                    Text("\(habits) Habits")
                        .foregroundColor(.white)
                        .font(Font.inter(size: 3))
                        .padding(.horizontal, 3)
                        .padding(.vertical, 2)
                        .background(Color.black.opacity(0.75))
                        .cornerRadius(5)
                        .fixedSize(horizontal: true, vertical: false)
                }.padding(.bottom)
                
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.sfPro(size: 7, weight: .semibold))
                
                Text(subtitle)
                    .foregroundColor(.gray)
                    .font(Font.sfPro(size: 5, weight: .regular))
                    .lineLimit(2)
            }
            .padding()
        }
        .frame(width: 80, height: 85)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
      //  .clipped()
    }
}


#Preview {
    ExploreMain()
}
