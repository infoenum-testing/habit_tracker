//
//  TrendingCardView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct HabitCardCellView: View {
    
    let habit: HabitTemplate
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                // Icon Section
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.ractangleColor)
                        .frame(width: 52, height: 52)
                    
                    Image(habit.icon ?? "tooth")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(ColorToken.from(string: habit.colorToken ?? ""))
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                
               // This pushes the text section down to fill remaining space
                
                // Text Section
                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.title ?? "")
                        .foregroundColor(.white)
                        .font(Font.inter(size: 16, weight: .semibold))
                        .multilineTextAlignment(.leading)
                    
                    Text(habit.details ?? "")
                        .foregroundColor(.gray)
                        .font(Font.inter(size: 12, weight: .regular))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .leading)
                .padding(.bottom, 10) // bottom padding
               // Spacer()
            }
            .padding(.horizontal, 20)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.cellBackgroundColor)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.ractangleColor, lineWidth: 0.8)
            )
        }
    }
}

