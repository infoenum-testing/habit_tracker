//
//  TrendingCardView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 22/08/25.
//

import SwiftUI

struct HabitCardCellView: View {
    
    let habit: HabitTemplate
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.ractangleColor)
                        .frame(width: 50, height: 50)
                    
                    Image(habit.icon ?? "tooth")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(ColorToken.from(string: habit.colorToken ?? ""))
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.title ?? "")
                        .foregroundColor(.white)
                        .font(Font.inter(size: 16, weight: .semibold))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(habit.details ?? "")
                        .foregroundColor(.gray)
                        .font(Font.inter(size: 12, weight: .regular))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topLeading)
                .padding(.bottom, 10)
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


struct NewHabitCardCell: View {
    
    let habit: HabitTemplate
    
    var body: some View {
        HStack {
            Image(habit.icon ?? "tooth")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(ColorToken.from(string: habit.colorToken ?? ""))
                .padding(.leading, 10)
            
            
            VStack(alignment: .leading, spacing: 3) {
                Text(habit.title ?? "")
                    .foregroundColor(.white)
                    .font(Font.sfPro(size: 14, weight: .semibold))
                
                Text(habit.details ?? "")
                    .font(Font.sfPro(size: 12, weight: .light))
                    .foregroundColor(.white.opacity(0.75))
                    
            }
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("ADD")
                    .font(Font.sfPro(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
            }.padding(.trailing, 17)
        }
         .padding(.vertical, 10)
         .background(Color(red: 0.04, green: 0.04, blue: 0.04))
         .cornerRadius(18)
         .padding(.horizontal, 24)
         
    }
}

