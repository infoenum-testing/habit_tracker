//
//  CircularArcProgressView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 08/09/25.
//

import SwiftUI

struct CircularArcProgressView: View {
    var progress: Double
    var tint: Color
    
    var body: some View {
        ZStack {
            // Base circle
            Circle()
                .stroke(Color(UIColor.appGray), lineWidth: 12)
            
            // Progress circle with animation
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    tint,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90)) // start at top
                .animation(.easeInOut(duration: 0.6), value: progress) // animate
            
            // Center icon
            Image("star")
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(width: 135, height: 135)
    }
}
