//
//  TabButton.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import SwiftUI
import Foundation

struct TabButton: View {
    let icon: String
    let selectedIcon: String    
    let idx: Int
    @Binding var tab: Int

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) { tab = idx }
        } label: {
            ZStack {
                Image(tab == idx ? selectedIcon : icon)
                    .resizable()
                    .frame(width: tab == idx ? 70 : 50, height: 50)
                    .foregroundStyle(.white)
                    .transition(.opacity)
                
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}
