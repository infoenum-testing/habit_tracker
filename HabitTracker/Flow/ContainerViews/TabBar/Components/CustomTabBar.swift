//
//  CustomTabBar.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import SwiftUI
import Foundation

struct CustomTabBar: View {
    @Binding var tab: Int
    var body: some View {
        HStack {
            TabButton(icon: "homeTab", selectedIcon: "selectedHomeTab", idx: 0, tab: $tab)
                .frame(width: 80, height: 60)
            TabButton(icon: "navigationTab", selectedIcon: "selectedNavigationTab", idx: 1, tab: $tab)
                .frame(width: 80, height: 60)
            TabButton(icon: "graphTab", selectedIcon: "selectedGraphTab", idx: 2, tab: $tab)
                .frame(width: 80, height: 60)
            TabButton(icon: "profileTab", selectedIcon: "selectedProfileTab", idx: 3, tab: $tab)
                .frame(width: 80, height: 60)
        }
        .padding(.horizontal, 24)
        .frame(height: 65)
        .background(.black)
    }
}
