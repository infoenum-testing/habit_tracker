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
                        .fill(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2))
                        .frame(width: 52, height: 52)
                    
                    Image(habit.icon ?? "tooth")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(ColorToken.from(string: habit.colorToken ?? ""))
                }
                .padding(.top, 12)
                
                Spacer() // This pushes the text section down to fill remaining space
                
                // Text Section
                VStack(alignment: .leading, spacing: 6) {
                    Text(habit.title ?? "")
                        .foregroundColor(.white)
                        .font(Font.inter(size: 18, weight: .semibold))
                        .multilineTextAlignment(.leading)
                    
                    Text(habit.details ?? "")
                        .foregroundColor(.gray)
                        .font(Font.inter(size: 14, weight: .semibold))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12) // bottom padding
            }
            .padding(.horizontal, 26)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2), lineWidth: 0.8)
            )
        }
    }
}

//#Preview {
//    HabitCardCellView(habit: T##HabitTemplate, )
//        .padding()
//        .background(Color.black)
//}
