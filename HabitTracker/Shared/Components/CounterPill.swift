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
                .stroke(Color(UIColor.appGray), lineWidth: 6)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))  // Start from top
            
            // Text in the middle
            Text(text)
                .font(.sfProDisplay(.bold, size: 13))
                .foregroundColor(.white)
        }
        .frame(width: 40, height: 40)
    }
}
