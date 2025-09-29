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
            VStack {
                
            }.frame(width: 40 , height: 40)
                .background(Color.customBlack)
                .cornerRadius(20)
            
            Circle()
                .stroke(.white.opacity(0.10), lineWidth: 5)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))  // Start from top
            
            // Text in the middle
            HStack(spacing:0) {
                Text("\(completed)")
                    .font(.sfProDisplay(.medium, size: 16))
                    .foregroundColor(.white)
                Text("/")
                    .font(.sfProDisplay(.medium, size: 16))
                    .foregroundColor(.white.opacity(0.5))
                Text("\(total)")
                    .font(.sfProDisplay(.medium, size: 16))
                    .foregroundColor(.white.opacity(0.5))
            }
        }
        .frame(width: 48, height: 48)
       
    }
}
