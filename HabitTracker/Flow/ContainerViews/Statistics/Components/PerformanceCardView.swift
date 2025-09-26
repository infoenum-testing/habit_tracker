//
//  PerformanceCardView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import Foundation
import SwiftUI

struct PerformanceCardView: View {
    
    let iconName: String
    let title: String
    let score: Int
    let delta: Int
    
    var body: some View {
        
        ZStack {
            
            Image(StringConstants.Image.coin)
                .offset(x: 14)
                .overlay(alignment: .topTrailing, content: {
                    HStack(spacing: 4) {
                        Image(StringConstants.Image.medalIcon)
                        
                        Text("\(score)x")
                            .font(.sfProDisplay(.medium, size: 12))
                            .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))

                    }.padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .frame(height: 18, alignment: .center)
                        .background(Color.appCyan)
                        .cornerRadius(40).padding(.top, 6)
                })
            
            VStack {
                Spacer()
                Text(title)
                    .font(.inter(size: 15, weight: .medium))
                    .foregroundStyle(.white)
                
                Text("Jul 15 2025")
                    .font(.inter(size: 10))
                    .foregroundColor(.white.opacity(0.5))
                
            }.offset(y: -9)
        }.padding(.bottom, 10).frame(maxWidth: .infinity)
        .background(Color(red: 0.08, green: 0.08, blue: 0.08).opacity(0.31))
        .cornerRadius(16)
    }
}
