//
//  CounterPill.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//


import SwiftUI
import Foundation

struct CounterPill: View {
    var text: String
    var tint: Color
    var completed: Int
    var total: Int
    
    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(completed) / CGFloat(total)
    }
    
    var body: some View {
        ZStack {
            // Background ring (gray)
            Circle()
                .stroke(.white.opacity(0.10), lineWidth: 5)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))  // Start from top
            
            // Text in the middle
            Text(text)
                .font(.sfProDisplay(.bold, size: 14))
                .foregroundColor(.white)
        }
        .frame(width: 45, height: 45)
    }
}
