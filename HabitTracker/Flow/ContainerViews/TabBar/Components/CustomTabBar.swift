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
            TabButton(icon: StringConstants.Image.homeTab, selectedIcon: StringConstants.Image.selectedHomeTab, idx: 0, tab: $tab)
                .frame(width: 80, height: 60)
            TabButton(icon: StringConstants.Image.navigationTab, selectedIcon: StringConstants.Image.selectedNavigationTab, idx: 1, tab: $tab)
                .frame(width: 80, height: 60)
            TabButton(icon: StringConstants.Image.graphTab, selectedIcon: StringConstants.Image.selectedGraphTab, idx: 2, tab: $tab)
                .frame(width: 80, height: 60)
            TabButton(icon: StringConstants.Image.profileTab, selectedIcon: StringConstants.Image.selectedProfileTab, idx: 3, tab: $tab)
                .frame(width: 80, height: 60)
        }
        //.padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(.tabBackground)
        
        
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.appGray),
            alignment: .top
        )
    }
}
