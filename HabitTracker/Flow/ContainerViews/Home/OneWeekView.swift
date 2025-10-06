//
//  WeekView.swift
//  HabitTracker
//
//  Created by Mayur Shivas on 04/10/25.
//

import SwiftUI

struct OneWeekView: View {
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
                        VStack(spacing: 5) {
                            ZStack {

                                Text(dateFormatter.string(from: date)) // Day number
                                    .font(.inter(size: 14, weight: .regular))
                                    .foregroundColor(.white)
                                    .padding(10)
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
        formatter.dateFormat = "E" // Sun, Mon, Tue...
        return formatter.string(from: date)
    }
}
