//
//  StatisticsView.swift
//  HabitTracker
//
//  Created by IE14 on 20/08/25.
//

import SwiftUI
import Foundation

struct StatisticsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text("Statistics")
                    .font(.title2)
                    .bold()
                    .padding(.top, 16)

                // Overall Score Card
                OverallScoreCard()

                // Daily Performance
                Text("Daily Performance")
                    .font(.subheadline)
                    .bold()

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    PerformanceCardView(iconName: "disciplineIcon",
                                        title: "Discipline",
                                        score: 73,
                                        delta: 1)
                    PerformanceCardView(iconName: "strengthIcon",
                                        title: "Strength",
                                        score: 68,
                                        delta: 3)
                    PerformanceCardView(iconName: "confidenceIcon",
                                        title: "Confidence",
                                        score: 70,
                                        delta: 3)
                    PerformanceCardView(iconName: "intelligenceIcon",
                                        title: "Intelligence",
                                        score: 71,
                                        delta: 1)
                }
                
                WeeklyPerformanceView()
            }
            .padding(.horizontal, 16)
        }
        .background(Color.black.ignoresSafeArea())
    }
}


struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
            .preferredColorScheme(.dark)
    }
}



struct PerformanceCardView: View {
    let iconName: String
    let title: String
    let score: Int
    let delta: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(iconName)
                Spacer()
            }
            Text("[archetype]")
                .font(.caption2)
                .foregroundColor(.gray)
            Text(title)
                .font(.headline)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(score)")
                    .font(.title)
                    .bold()
                
                Text("+\(delta)")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(6)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.appGray))
        .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.appGreen.opacity(0.5), lineWidth: 2)
                    )
                .padding(2)
    }
}



struct OverallScoreCard: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.15))
                .frame(height: 160)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkle") // placeholder icon
                        Text("[archetype]")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }

                    Text("Overall Score")
                        .font(.headline)

                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("287")
                            .font(.system(size: 42, weight: .bold))

                        HStack(spacing: 4) {
                            Text("+8")
                                .font(.caption2)
                            Image(systemName: "arrow.up")
                                .font(.caption2)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.25))
                        .cornerRadius(10)
                    }

                    Text("Updated Daily")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image("overallGraph")              // <-- your static image of the curve
                    .resizable()
                    .scaledToFit()
                    .frame(height: 130)
                    .offset(x: 10, y: 10)          // small offset to match screenshot
            }
            .padding()

            // "Today" pill
            Text("Today")
                .font(.caption2)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.green.opacity(0.25))
                .cornerRadius(10)
                .padding(.top, 8)
                .padding(.trailing, 8)
        }
    }
}


struct WeeklyPerformanceView: View {
    private let values: [CGFloat] = [100, 50, 25, 100, 75, 40, 15]
    private let days  = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weekly Performance")
                .font(.subheadline)
                .bold()
                .padding(.bottom)

            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.black.opacity(0.15))

                // grid & number labels
                VStack(alignment: .leading, spacing: 0) {
                    ForEach([100,75,50,25,0], id: \.self) { label in
                        HStack(spacing: 6) {
                            Text("\(label)")
                                //.font(.caption2)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.gray)
                                .frame(width: 30, alignment: .leading)

                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.white.opacity(0.15))
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)

                // bars + day labels
                GeometryReader { geo in
                    let barWidth: CGFloat = 18
                    let availableWidth = geo.size.width - 60   // space for padding + y-axis labels
                    let spacing = (availableWidth - (barWidth * 7)) / 6  // spacing between 7 bars

                    HStack(alignment: .bottom, spacing: spacing) {
                        ForEach(0..<values.count, id: \.self) { index in
                            VStack(spacing: 4) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.white)
                                    .frame(
                                        width: barWidth,
                                        height: (values[index] / 100) * (geo.size.height - 40)  // leaving top/bottom insets
                                    )

                                Text(days[index])
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 42)
                    .padding(.bottom, 10)
                }
            }
            .frame(height: 190)
        }
    }
}
