//
//  MyAccountView.swift
//  HabitTracker
//
//  Created by IE14 on 20/08/25.
//

import SwiftUI
import Foundation


struct MyAccountView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("My Account")
                    .font(.title2)
                    .bold()
                    .padding(.top, 16)

                Text("Completed Arcs")
                    .font(.subheadline)
                    .bold()

                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    ArcCardView(title: "75 Hard",      days: 75, date: "July 18, 2025", iconColor: .red)
                    ArcCardView(title: "Gut Health",   days: 60, date: "July 18, 2025", iconColor: .green)
                    ArcCardView(title: "White Smile",  days: 30, date: "July 18, 2025", iconColor: .purple)
                    ArcCardView(title: "Project 50",   days: 50, date: "July 18, 2025", iconColor: .orange)
                }
                .padding(.horizontal, 16)

                Group {
                    // Notifications row
                    HStack {
                        Image(systemName: "bell")
                        Text("Notifications")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.black.opacity(0.15))
                    .cornerRadius(18)

                    // Account Settings
                    HStack {
                        Image(systemName: "gearshape")
                        Text("Account Settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.black.opacity(0.15))
                    .cornerRadius(18)

                    // Terms of Service
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Terms of Service")
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.black.ignoresSafeArea())
    }
}


struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
            .preferredColorScheme(.dark)
    }
}


struct ArcCardView: View {
    let title: String
    let days: Int
    let date: String
    let iconColor: Color

    var body: some View {
        ZStack {
            // background large card
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.gray.opacity(0.20))  // light gray
                .frame(height: 180)

            // inner white card
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .frame(height: 100)
                .padding(.top, 18)

            // icon + text
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 12)   // placeholder for the colored icon
                    .fill(iconColor)
                    .frame(width: 48, height: 48)

                Text(title)
                    .font(.headline)

                Text("\(days) Days")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(date)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.top, 8)
        }
        .frame(height: 180)
    }
}
