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
        VStack(alignment: .leading){
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 20, height: 20)
                    .background(Color.ractangleColor)
                    .cornerRadius(4)
                if let image = habit.icon {
                    Image(image)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(ColorToken.from(string: habit.colorToken ?? ""))
                }
            }
            .padding(.bottom,5)
            
            
            VStack(alignment: .leading, spacing: 2) {
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
            
        }
        .padding(10)
        .frame(width: 80, height: 80)
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
