//
//  ArcCardView.swift
//  HabitTracker
//
//  Created by IE14 on 21/08/25.
//

import SwiftUI
import Foundation

struct ArcCardView: View {
    let title: String
    let days: Int
    let date: String
    let icon : String
    let iconColor: Color
    let width : CGFloat = UIScreen.main.bounds.width / 2.3
    let height : CGFloat = UIScreen.main.bounds.width / 2.3

    var body: some View {
        ZStack {
            VStack {
                // 1st layer: background large card
                Spacer()
                VStack {
                    // 2nd layer: background small card
                } .frame(height: 110)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(8)
                    .shadow(radius: 10)
            }
            .frame(width: width, height: height)
                .background(.appPearlWhite)
                .cornerRadius(25)
                .shadow(radius: 10)
            VStack(spacing: 0) {
                Image(icon)
                    .resizable()
                    .foregroundStyle(iconColor)
                    .frame(width: 60, height: 60)
                    .shadow(radius: 5)
                    .padding(.top, 10)
                Text(title)
                    .font(.sfProDisplay(.semibold, size: 12))
                    .foregroundColor(.textBlack)
                    .padding(.top, 12)
                Text("\(days) Days")
                    .font(.sfProDisplay(.medium, size: 9))
                    .foregroundColor(.textGray)
                    .padding(.top, 2)
                Text(date)
                    .font(.sfProDisplay(.medium, size: 9))
                    .foregroundColor(.textGray)
            }
        }
    }
}


struct EmptyArcCardView: View {
    let title: String
    let width: CGFloat = UIScreen.main.bounds.width / 2.3
    let height: CGFloat = UIScreen.main.bounds.width / 2.3
    
    var body: some View {
        VStack(spacing: 12) {
//            Image(systemName: "checkmark.seal")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.gray.opacity(0.7))
            
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text("Start a new arc to see it here!")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.6))
        }
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.cellBackgroundColor)
                .shadow(radius: 8)
        )
    }
}

