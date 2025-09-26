//
//  CheckChip.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

//import SwiftUI
//import Foundation
//
//struct CheckChip: View {
//    var isOn: Bool
//    var tint: Color
//    var tap: () -> Void
//    
//    var body: some View {
//        Button(action: tap) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(isOn ? tint : Color(UIColor.appGray))
//                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isOn)
//                Image("check")
//                    .resizable()
//                    .frame(width: 22, height: 22)
//                    .foregroundStyle(.white)
//                    .scaleEffect(isOn ? 1.1 : 1.0)
//                    .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isOn)
//            }
//            .frame(width: 45, height: 45)
//        }
//        .buttonStyle(.plain)
//    }
//}

import SwiftUI

struct CheckChip: View {
    var isOn: Bool
    var tint: Color = .green
    var tap: () -> Void
    
    var body: some View {
        Button(action: tap) {
            ZStack {
                // Outer circle (border only)
                Circle()
                    .stroke(isOn ? tint : Color.gray.opacity(0.6), lineWidth: 2)
                
                // Inner circle with a gap
                if isOn {
                    Circle()
                        .fill(tint)
                        .frame(width: 25, height: 25) // smaller to create visible gap
                    
                    Image("check")
                        .resizable()
                        .frame(width: 18, height: 15)
                        .foregroundColor(.black)
                }
            }
            .frame(width: 30, height: 30)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isOn)
        }
        .buttonStyle(.plain)
    }
}
