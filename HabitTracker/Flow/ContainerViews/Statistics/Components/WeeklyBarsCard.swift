//
//  WeeklyBarsCard.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import SwiftUI
import Charts

// MARK: - View

struct WeeklyBarsCard: View {
    
    @EnvironmentObject var appData: AppDataStore
    
    private let cardBG = Color(.graphBackground)
    private let gridLine = Color.white
    private let yLabel  = Color.white.opacity(0.70)
    private let barFill = Color.white
    var body: some View {
        let dayOrder = appData.currentWeekDayLabels
        let data = appData.weeklyDayValues
        ZStack {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(cardBG)
            
            Chart(data) { item in
                BarMark(
                    x: .value(StringConstants.Account.day, item.day),
                    y: .value(StringConstants.Account.value, item.value),
                    width: .fixed(18)
                )
                .foregroundStyle(barFill)
                .cornerRadius(4)
            }
            .chartYScale(domain: 0...100)
            .chartXScale(domain: dayOrder)
            .chartXAxis {
                AxisMarks(position: .bottom, values: dayOrder) { value in
                    AxisValueLabel {
                        if let day = value.as(String.self) {
                            Text(day)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                            
                        }
                    }
                }
            }
            
            .chartYAxis {
                AxisMarks(position: .leading,
                          values: Array(stride(from: 0, through: 100, by: 25))) { value in
                    
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [6, 6]))
                        .foregroundStyle(Color.white.opacity(0.5))
                    
                    AxisValueLabel {
                        if let v = value.as(Double.self) {
                            Text(String(format: "%.0f", v))
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.white.opacity(0.8))
                            
                        }
                    }
                }
            }
            
            .chartPlotStyle { plotArea in
                plotArea
                    .background(.clear)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .frame(height: 250)
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
    }
}

// MARK: - Preview

struct WeeklyBarsCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeeklyBarsCard()
                .previewDisplayName(StringConstants.Account.dark)
                .preferredColorScheme(.dark)
            
            WeeklyBarsCard()
                .previewDisplayName(StringConstants.Account.lightForComparison)
                .preferredColorScheme(.light)
        }
    }
}
