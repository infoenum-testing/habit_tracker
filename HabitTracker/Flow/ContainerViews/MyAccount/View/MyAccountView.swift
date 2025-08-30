//
//  MyAccountView.swift
//  HabitTracker
//
//  Created by IE14 on 20/08/25.
//

import SwiftUI
import Foundation


struct MyAccountView: View {
    @EnvironmentObject private var appState: AppDataStore
    
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
                        rows: Array(repeating: GridItem(.flexible(), spacing: 0), count: 2),
                        spacing: 15
                    ) {
                        
//                        ForEach(appState.allHistories, id: \.id) { badge in
//                            let color = ColorToken.from(string: badge.color ?? "white")
//                            let badgeImage: String = ColorToken.imageName(from: badge.color ?? "white")
//                            ArcCardView(title: badge.arcTitle ?? "",  days: Int(badge.arcDays), date: badge.completedAt?.toReadableString() ?? "", icon: badgeImage, iconColor: color)
//                        }
                        
                        
                            ArcCardView(
                                title: "Arc of Discipline",
                                days: 60,
                                date: "18 July 2025",
                                icon: "arcRed",
                                iconColor: .appRed
                            )
                        
                            ArcCardView(
                                title: "Gut Health",
                                days: 60,
                                date: "17 July 2025",
                                icon: "arcGreen",
                                iconColor: .appGreen
                            )
                        
                            ArcCardView(
                                title: "Project 50",
                                days: 60,
                                date: "12 July 2025",
                                icon: "arcPurple",
                                iconColor: .appPurple
                            )
                        
                            ArcCardView(
                                title: "75 Hard",
                                days: 60,
                                date: "12 July 2025",
                                icon: "arcYellow",
                                iconColor: .appYellow
                            )
                      

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
