//
//  Untitled.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//
import Foundation
import SwiftUI

struct TopArcCardView: View {
    var title: String
    var subtitle: String
    var days: String
    var habits: String
    var imageName: String
    var color: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 85)
                .clipped()            
            // Overlay content
            VStack(alignment: .leading, spacing: 4) {
                if days != "" {
                    HStack {
                        Text("\(days) Days")
                            .foregroundColor(.white)
                            .font(Font.inter(size: 3))
                            .padding(.horizontal, 3)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(5)
                            .fixedSize(horizontal: true, vertical: false)
                        Text("\(habits) Habits")
                            .foregroundColor(.white)
                            .font(Font.inter(size: 3))
                            .padding(.horizontal, 3)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(5)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .padding(.bottom)
                }
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.sfPro(size: 7, weight: .semibold))
                
                Text(subtitle)
                    .foregroundColor(.gray)
                    .font(Font.sfPro(size: 5, weight: .regular))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .frame(width: 80, height: 80)
        .background(Color.cellBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .black.opacity(0.6), radius: 3.6, x: -7.2, y: 9.6)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.16)
                .stroke(ColorToken.from(string: color), lineWidth: 1)
            
        )
    }
}
