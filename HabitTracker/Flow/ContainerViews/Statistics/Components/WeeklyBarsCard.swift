//
//  WeeklyBarsCard.swift
//  HabitTracker
//
//  Created by IE14 on 21/08/25.
//

import SwiftUI
import Charts

// MARK: - Model

struct DayValue: Identifiable {
    let id = UUID()
    let day: String   // "Mon", "Tue", ...
    let value: Double // 0...100
}

// MARK: - View

struct WeeklyBarsCard: View {
    // Dummy data Mon → Sun (adjusted to roughly match the screenshot’s pattern)
    private let data: [DayValue] = [
        .init(day: "Mon", value: 100),
        .init(day: "Tue", value: 50),
        .init(day: "Wed", value: 10),
        .init(day: "Thu", value: 25),
        .init(day: "Fri", value: 100),
        .init(day: "Sat", value: 65),
        .init(day: "Sun", value: 15)
    ]
    
    // Keep the days ordered Mon → Sun
    private let dayOrder = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    // Palette tuned for the screenshot look
    private let cardBG = Color(red: 0.14, green: 0.14, blue: 0.14)       // near-black charcoal
    private let gridLine = Color.white.opacity(0.20)                      // faint dashed grid
    private let yLabel  = Color.white.opacity(0.70)                       // y-axis labels
    private let barFill = Color.white                                     // bars
    
    var body: some View {
        ZStack {
            // Card background with rounded corners + subtle stroke to match the image
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(cardBG)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20, style: .continuous)
//                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
//                )
//                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 2)
            
            // Chart content
            Chart(data) { item in
                // A narrow, rounded white bar for each day
                BarMark(
                    x: .value("Day", item.day),
                    y: .value("Value", item.value),
                    width: .fixed(16) // narrower bars like the screenshot
                )
                .foregroundStyle(barFill)
                .cornerRadius(6)
            }
            .chartYScale(domain: 0...100) // match the 0–100 scale in the image
            .chartXScale(domain: dayOrder) // lock order Mon → Sun
            .chartXAxis {
                AxisMarks(position: .bottom, values: dayOrder) { value in
                    AxisValueLabel {
                        if let day = value.as(String.self) {
                            Text(day)
                                
                                //.font(.sfproDisplay(.semibold, size: 14))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.white)
                        }
                    }
                    AxisTick()
                }
            }

            .chartYAxis {
                AxisMarks(position: .leading,
                          values: Array(stride(from: 0, through: 100, by: 25))) { value in
                    
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [6, 6]))
                        .foregroundStyle(Color.white.opacity(0.2))
                    
                    AxisValueLabel {
                        if let v = value.as(Double.self) {
                            Text(String(format: "%.0f", v))
                                //.font(.sfproDisplay(.semibold, size: 14))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }

            .chartPlotStyle { plotArea in
                // Clear plot background so the card’s dark background shows through
                plotArea
                    .background(.clear)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .frame(height: 250) // similar vertical footprint to the screenshot
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
    }
}

// MARK: - Preview

struct WeeklyBarsCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeeklyBarsCard()
                .previewDisplayName("Dark")
                .preferredColorScheme(.dark)
            
            WeeklyBarsCard()
                .previewDisplayName("Light (for comparison)")
                .preferredColorScheme(.light)
        }
    }
}
