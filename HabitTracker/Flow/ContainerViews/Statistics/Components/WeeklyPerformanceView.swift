//
//  WeeklyPerformanceView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import Foundation
import SwiftUI

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

struct WeeklyPerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyPerformanceView()
            .padding()
            .background(Color.black.opacity(0.1))
            .previewLayout(.sizeThatFits)
    }
}
