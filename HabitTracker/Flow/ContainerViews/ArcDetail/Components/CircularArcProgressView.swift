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


import SwiftUI

struct LinearArcProgressView: View {
    var title: String
    var completed: Int
    var total: Int
    var tint: Color = .green
    
    private var progress: Double {
        total == 0 ? 0 : Double(completed) / Double(total)
    }
    
    var body: some View {
        VStack {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(Font.inter(size: 12, weight: .regular))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(completed)/\(total)")
                    .font(Font.inter(size: 12, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
            }
           
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.progressBackground)
                        .frame(height: 6)
                    
                    // Progress fill
                    RoundedRectangle(cornerRadius: 4)
                        .fill(tint)
                        .frame(width: geometry.size.width * progress, height: 6)
                        .animation(.easeInOut(duration: 0.4), value: progress)
                }
            }
            .frame(height: 6)
        }
        .frame(height: 50)
        .padding()
    }
        .frame(height: 50)
        .background(Color.white.opacity(0.10))
        .cornerRadius(12)
        
    }
}
