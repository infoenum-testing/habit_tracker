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
                HStack {
                    Spacer()
                    Text("My Account")
                        .font(.sfProDisplay(.semibold, size: 21))
                    Spacer()
                }
                
                Text("Completed Arcs")
                    .font(.sfProDisplay(.medium, size: 19))
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(
                           rows: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
                           spacing: 10
                       ) {
                    ArcCardView(title: "75 Hard",  days: 75, date: "July 18, 2025", icon: "greenArc", iconColor: .red)
                    ArcCardView(title: "Gut Health",   days: 60, date: "July 18, 2025", icon: "redArc", iconColor: .green)
                    ArcCardView(title: "White Smile",  days: 30, date: "July 18, 2025", icon: "purpleArc", iconColor: .purple)
                    ArcCardView(title: "Project 50",   days: 50, date: "July 18, 2025", icon: "orangeArc", iconColor: .orange)
                }
                .frame(height: 384)
            }

                VStack(spacing: 14) {
                    SettingsRow(imageName: "notification",
                                title: "Notifications",
                                background: .appDarkGray) {
                        print("Notifications tapped")
                    }

                    SettingsRow(imageName: "profile",
                                title: "Account Settings",
                                background: .appDarkGray) {
                        print("Account Settings tapped")
                    }

                    SettingsRow(imageName: "share",
                                title: "Terms of Service",
                                background: .clear) {
                        print("Terms of Service tapped")
                    }
                }
            }
            .padding(.horizontal)
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
