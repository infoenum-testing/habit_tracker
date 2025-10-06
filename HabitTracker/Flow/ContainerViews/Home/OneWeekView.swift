//
//  OneWeekView.swift
//  HabitTracker
//
//  Created by Mayur Shivas on 04/10/25.
//

import SwiftUI

struct OneWeekView: View {
    let arc: [SubscribedArc]
    @State private var currentDate = Date()
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d" // Just the day number
        return formatter
    }()
    
    // Get all dates of the current week (Sunday to Saturday)
    private var currentWeekDates: [Date] {
        var weekDates: [Date] = []
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: sunday) {
                weekDates.append(date)
            }
        }
        return weekDates
    }
    
    var body: some View {
        
            HStack(spacing: 10) {
                ForEach(currentWeekDates, id: \.self) { date in
                    VStack (spacing: 14){
                        Text(shortWeekday(date: date)) // Sun, Mon, etc
                            .font(.inter(size: 14, weight: .regular))
                            .foregroundColor(.white)
                        VStack(spacing: 10) {
                            ZStack {
                                if arc.count >= 3 {
                                    CircleView(
                                        fillColour: ColorToken.from(string: arc[2].wrappedThemeColor),
                                        size: 40,
                                        progress: progress(
                                            total: arc[2].wrappedHabitsCount,
                                            completed: completedHabits(for: arc[2], on: date)
                                        )
                                    )
                                } else {
                                    CircleView(fillColour: Color.clear, size: 40, progress: 0.0)
                                }
                                
                                if arc.count >= 2 {
                                    CircleView(
                                        fillColour: ColorToken.from(string: arc[1].wrappedThemeColor),
                                        size: 33,
                                        progress: progress(
                                            total: arc[1].wrappedHabitsCount,
                                            completed: completedHabits(for: arc[1], on: date)
                                        )
                                    )
                                } else {
                                    CircleView(fillColour: Color.clear, size: 33, progress: 0.0)
                                }
                                
                                if arc.count >= 1 {
                                    CircleView(
                                        fillColour: ColorToken.from(string: arc[0].wrappedThemeColor),
                                        size: 25,
                                        progress: progress(
                                            total: arc[0].wrappedHabitsCount,
                                            completed: completedHabits(for: arc[0], on: date)
                                        )
                                    )
                                } else {
                                    CircleView(fillColour: Color.clear, size: 25, progress: 0.0)
                                }
                                
                                Text(dateFormatter.string(from: date))
                                    .font(.inter(size: 14, weight: .regular))
                                    .foregroundColor(.white)
                                    .padding(10)
                               if date < Date() && !calendar.isDate(date, inSameDayAs: currentDate)  {
                                   ZStack {
                                       Circle()
                                           .fill(Color._151518.opacity(0.5))
                                           .frame(width: 22, height: 22)
                                       Image(.tickIcon)
                                           .resizable()
                                           .frame(width: 8, height: 6, alignment: .center)
                                   }
                                }
                            }
                            
                            Circle()
                                .foregroundColor(calendar.isDate(date, inSameDayAs: currentDate) ? Color.white : Color.clear)
                                .frame(width: 5, height: 5)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }        
        .padding()
    }
    
    private func shortWeekday(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
    
    func CircleView(fillColour: Color, size: CGFloat, progress: CGFloat )-> some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.10), lineWidth: 2)
                .frame(width: size, height: size, alignment: .center)
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(fillColour, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .rotationEffect(.degrees(-90))  // Start from top
                .frame(width: size, height: size, alignment: .center)
        }
    }
    
    func progress(total: Int, completed: Int)-> CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(completed) / CGFloat(total)
    }
        
    func completedHabits(for arc: SubscribedArc, on date: Date) -> Int {
        let calendar = Calendar.current

        // allProgress is already [ArcProgress], no need to unwrap
        if let progressForDay = arc.allProgress.first(where: {
            calendar.isDate($0.date ?? Date(), inSameDayAs: date)
        }) {
            return Int(progressForDay.completedHabits)
        }
        return 0
    }

}
