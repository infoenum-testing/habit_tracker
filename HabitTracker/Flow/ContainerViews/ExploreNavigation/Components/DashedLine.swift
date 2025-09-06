//
//  DashedLine.swift
//  HabitTracker
//
//  Created by IE14 on 06/09/25.
//
import SwiftUI

struct DashedLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 1) 
            .foregroundColor(.clear)
            .background(
                Color.clear
                    .overlay(
                        Rectangle()
                            .stroke(Color.white.opacity(0.09), style: StrokeStyle(lineWidth: 1.14, dash: [5]))
                    )
            )
    }
}
