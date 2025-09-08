//
//  ArcCardView.swift
//  HabitTracker
//


import SwiftUI
import Foundation

struct ArcCardView: View {
    let title: String
    let days: Int
    let date: String
    let icon : String
    let iconColor: Color
    let width : CGFloat = UIScreen.main.bounds.width / 2 - 40
    let height : CGFloat = UIScreen.main.bounds.width / 2 - 40
    

    var body: some View {
        let innerHeight: CGFloat = width * (110.0 / 180.0)
        let nestedSize: CGFloat = width * (60.0 / 180.0)
        ZStack {
            VStack {
                // 1st layer: background large card
                Spacer()
                VStack {
                    // 2nd layer: background small card
                } .frame(height: innerHeight)
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
                    .frame(width: nestedSize, height: nestedSize)
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


