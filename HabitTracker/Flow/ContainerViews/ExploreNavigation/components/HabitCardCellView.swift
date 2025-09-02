//
//  TrendingCardView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

//
//  TrendingCardView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct HabitCardCellView: View {
    let habit: HabitTemplate
    let action: () -> Void
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 14) {
                // Icon Section
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2))
                        .frame(width: 52, height: 52)
                    
                    Image(habit.icon ?? "tooth")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                
                // Text Section
                VStack(alignment: .leading, spacing: 6) {
                    Text(habit.title ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(habit.details ?? "")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 26)
            .padding(.vertical, 15)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2), lineWidth: 0.8)
            )
            .onTapGesture {
                action()
            }
        }
    }
}

//#Preview {
//    HabitCardCellView(habit: T##HabitTemplate, )
//        .padding()
//        .background(Color.black)
//}
