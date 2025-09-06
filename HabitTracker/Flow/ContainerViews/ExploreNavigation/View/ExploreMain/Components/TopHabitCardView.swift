//
//  TopHabitCardView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//
import SwiftUI
import Foundation

struct TopHabitCardView: View {
    var habit: HabitTemplate
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 20, height: 20)
                    .background(Color.ractangleColor)
                    .cornerRadius(4)
                if let image = habit.icon {
                    Image(image)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(ColorToken.from(string: habit.colorToken ?? ""))
                }
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                if let title = habit.title {
                    Text(title)
                        .foregroundColor(.white)
                        .font(Font.sfPro(size: 7, weight: .semibold))
                }
                
                if let details = habit.details {
                    Text(details)
                        .foregroundColor(.gray)
                        .font(Font.sfPro(size: 5, weight: .regular))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
            
        }
        .padding()
        .frame(width: 75, height: 75)
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .black.opacity(0.6), radius: 3.6, x: -7.2, y: 9.6)
        .overlay(
            RoundedRectangle(cornerRadius: 7.36)
                .inset(by: 0.16)
                .stroke(Color.ractangleColor, lineWidth: 0.3)
            
        )
    }
}
