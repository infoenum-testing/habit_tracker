//
//  HomeScreen.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var swipeManager = SwipeManager()
    @State private var showEditArc = false
    @State private var showHabitEditSheet = false
    @State private var showToast: Bool = false
    @State private var showCreateHabitSheet = false
    @State private var showCreateArcSheet = false
    @State private var createdHabit = CreatedHabit(id: UUID(), title: "", description: "", icon: "", color: "")
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HomeHeader(swipeManager: swipeManager)
                    .padding(.top, 6)
                    .padding(.horizontal,20)
                //                DateStrip()
                OneWeekView(arc: appData.allSubscribedArcs)
                    .padding(.vertical, 4)
//                HStack {
//                    Text(StringConstants.Home.todaysHabits)
//                        .font(.sfProDisplay(.medium, size: 16))
//                        .foregroundStyle(.white)
//                        .minimumScaleFactor(0.8)
//                    
//                    Spacer()
//                    HStack(spacing: 4) {
//                        Text(Date().fullWeekday)
//                            .font(.sfProDisplay(.medium, size: 16))
//                            .foregroundStyle(.white)
//                            .minimumScaleFactor(0.8)
//                        Text(Date().monthDayYear)
//                            .font(.sfProDisplay(.medium, size: 16))
//                            .foregroundStyle(.white.opacity(0.40))
//                            .minimumScaleFactor(0.8)
//                    }
//                    
//                }.padding(.vertical, 12)
//                    .padding(.horizontal,20)
                
                if appData.allSubscribedArcs.isEmpty && appData.allSubscribedHabits.isEmpty {
                    VStack {
                        Spacer()
                        Text(StringConstants.Home.noTaskForToday)
                            .font(.sfProDisplay(.medium, size: 16))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            
                            VStack {
                                SectionHeader(title: "My Arcs") {
                                    print("Add Arc tapped")
                                    showCreateArcSheet = true
                                }
                                .padding(.bottom,10)
                                
                                
                                ForEach(appData.allSubscribedArcs) { arc in
                                    ArcRowList(arc: arc) {
                                        withAnimation(.spring()) {
                                            appData.selectedArctoDelete = arc
                                            showEditArc = true
                                            swipeManager.closeAll()
                                        }
                                    }
                                    
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            swipeManager.closeAll()
                                        }
                                        router.push(to: Route.arcDetail(id: arc.wrappedId))
                                    }
                                }
                            }
                            VStack {
                                SectionHeader(title: "Habits") {
                                    print("Add Habit tapped")
                                    showCreateHabitSheet = true
                                }
                                .padding(.vertical,10)
                                
                                ForEach(appData.allSubscribedHabits) { habit in
                                    HabitRowList(habit: habit, editHabitAction: {
                                        withAnimation(.spring()) {
                                            appData.selectedHabitToDelete = habit
                                            showHabitEditSheet = true
                                            swipeManager.closeAll()
                                        }
                                    })
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            swipeManager.closeAll()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 20)
                    }
                    .environmentObject(swipeManager)
                }
            }
        }
        .toolbar(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.homeSheetBackground)
        .navigationBarHidden(true)
        
        .sheet(isPresented: $showHabitEditSheet) {
            HabitEditSheet()
                .presentationBackground {
                    Color.color_151518
                }
                .preferredColorScheme(.dark)
                .presentationDetents([.height(500)])
                .presentationCornerRadius(24)
                .presentationDragIndicator(.hidden)
        }
        
        .sheet(isPresented: $showEditArc) {
            EditArcSheet(isPresented: $showEditArc)
                .presentationDetents([.height(400)])
                .presentationCornerRadius(24)
                .presentationBackground {
                    Color.color_151518
                }
                .preferredColorScheme(.dark)
        }
        
        .sheet(isPresented: $showCreateArcSheet) {
            CreateArcView()
                .presentationDetents([.large])
                .presentationCornerRadius(24)
                .presentationBackground {
                    Color.color_151518
                }
                .preferredColorScheme(.dark)
        }
        
        .sheet(isPresented: $showCreateHabitSheet) {
            CreateHabitView(isFromCreateArc: false, habit: $createdHabit, onSave: {_ in })
                .presentationDetents([.height(400)])
                .presentationCornerRadius(24)
                .presentationBackground {
                    Color.color_151518
                }
                .preferredColorScheme(.dark)
        }
        
        .onAppear {
            for arc in appData.allSubscribedArcs {
                if let graceEndDate = arc.graceEndDate,
                   graceEndDate < Date() {
                    let _ = appData.saveHistory(for: arc, status: .expired)
                    appData.deleteArc(arc)
                }
            }
        }
    }
    
    private struct SectionHeader: View {
        let title: String
        let action: () -> Void
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.sfProDisplay(.medium, size: 22))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: action) {
                    HStack {
                        Image("plusButton")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .padding()
                    }
                }
            }.frame(height: 30)
        }
    }
}


//MARK: - Dummy view for new date strip

struct HabitStatus {
    let date: Date
    let status: [HabitProgres] // Each habit’s progress (0.0 to 1.0)
}

enum HabitColor: CaseIterable {
    case orange, green, blue
    var color: Color {
        switch self {
        case .orange: return .orange
        case .green: return .green
        case .blue: return .blue
        }
    }
}

struct HabitProgres {
    let color: HabitColor
    let progress: Double // 0.0 to 1.0
}

struct WeekView: View {
    let weekStatus: [HabitStatus] // 7 entries, one for each day
    let today: Date

    var body: some View {
        HStack(spacing: 18) {
            ForEach(0..<weekStatus.count, id: \.self) { idx in
                let status = weekStatus[idx]
                let isToday = Calendar.current.isDate(status.date, inSameDayAs: today)
                VStack {
                    ZStack {
                        ForEach(Array(status.status.enumerated()), id: \.offset) { i, habit in
                            Circle()
                                .trim(from: 0.0, to: habit.progress)
                                .stroke(style: StrokeStyle(lineWidth: 3))
                                .foregroundColor(habit.color.color)
                                .frame(width: 40 - (CGFloat(i) * 10), height: 40 - (CGFloat(i) * 10))
                                .rotationEffect(.degrees(-90))
                        }
                    }
                    .frame(width: 40, height: 40)
                    Text(shortDayString(from: status.date))
                        .foregroundColor(.white)
                    if isToday {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 7, height: 7)
                            .offset(y: 6)
                    }
                }
            }
        }
    }

    func shortDayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}



struct Content: View {
    var body: some View {
        VStack {
            // Prepare data for the week (sample data given)
            let weekStatus = createSampleWeekStatus()
            let today = Date()
            WeekView(weekStatus: weekStatus, today: today)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }

    func createSampleWeekStatus() -> [HabitStatus] {
        let calendar = Calendar.current
        // Find the start of the week (Sunday)
        let today = Date()
        var weekDates: [Date] = []
        if let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) {
            for i in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: i, to: sunday) {
                    weekDates.append(date)
                }
            }
        }
        // Example progress for 3 habits each day
        return weekDates.map { date in
            HabitStatus(
                date: date,
                status: [
                    HabitProgres(color: .orange, progress: Double.random(in: 0...1)),
                    HabitProgres(color: .green, progress: Double.random(in: 0...1)),
                    HabitProgres(color: .blue, progress: Double.random(in: 0...1))
                ]
            )
        }
    }
}
