//
//  PerformanceCardView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import Foundation
import SwiftUI

struct CompletedArcView: View {
    
    let title: String
    let days: Int
    let date: String
    let icon : String
    let iconColor: Color
    let count: Int
    
    
    var body: some View {
        
        ZStack {
            
            Image(StringConstants.Image.coin)
                .offset(x: 14)
                .overlay(alignment: .topTrailing, content: {
                    HStack(spacing: 4) {
                        Image(StringConstants.Image.medalIcon)
                        
                        Text("\(count) x")
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
                
                Text(date)
                    .font(.inter(size: 10))
                    .foregroundColor(.white.opacity(0.5))
                
            }.offset(y: -9)
        }.padding(.bottom, 10).frame(maxWidth: .infinity)
        .background(Color(red: 0.08, green: 0.08, blue: 0.08).opacity(0.31))
        .cornerRadius(16)
    }
}
