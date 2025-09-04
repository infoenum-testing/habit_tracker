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
        VStack {
            HStack {
                Spacer()
                Text("My Account")
                    .font(.sfProDisplay(.semibold, size: 21))
                Spacer()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Completed Arcs")
                        .font(.sfProDisplay(.medium, size: 19))
                    let completedHistories = appState.allHistories.filter { $0.arcStatus == .completed }
                    
                    if completedHistories.count > 2 {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(
                                rows: Array(repeating: GridItem(.flexible(), spacing: 0), count: 2),
                                spacing: 15
                            ) {
                                
                                ForEach(appState.allHistories, id: \.id) { badge in
                                    let color = ColorToken.from(string: badge.color ?? "white")
                                    let badgeImage: String = ColorToken.imageName(from: badge.color ?? "white")
                                    if let status = badge.arcStatus, status == ArcStatus.completed {
                                        ArcCardView(title: badge.arcTitle ?? "",  days: Int(badge.arcDays), date: badge.completedAt?.toReadableString() ?? "", icon: badgeImage, iconColor: color)
                                    }
                                }
                            }
                            .frame(height: 384)
                        }
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: 15),
                                    GridItem(.flexible(), spacing: 15)
                                ],
                                spacing: 15
                            ) {
                                ForEach(appState.allHistories, id: \.id) { badge in
                                    let color = ColorToken.from(string: badge.color ?? "white")
                                    let badgeImage: String = ColorToken.imageName(from: badge.color ?? "white")
                                    
                                    if let status = badge.arcStatus, status == ArcStatus.completed {
                                        ArcCardView(
                                            title: badge.arcTitle ?? "",
                                            days: Int(badge.arcDays),
                                            date: badge.completedAt?.toReadableString() ?? "",
                                            icon: badgeImage,
                                            iconColor: color
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                        
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
            }
            .padding(.horizontal, 20)
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
