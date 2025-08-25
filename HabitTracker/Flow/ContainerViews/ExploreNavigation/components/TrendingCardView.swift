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

struct TrendingCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Icon Section
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2))
                    .frame(width: 52, height: 52)
                
                Image("teeth")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 29)
            }
            
            // Text Section
            VStack(alignment: .leading, spacing: 6) {
                Text("Brush & Floss")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Brush and floss your teeth today")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .lineLimit(2)
            }
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2), lineWidth: 0.8)
        )
    }
}

#Preview {
    TrendingCardView()
        .padding()
        .background(Color.black)
}
