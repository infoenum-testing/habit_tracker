//
//  SettingsRow.swift
//  HabitTracker
//
//  Created by IE14 on 21/08/25.
//

import SwiftUI
import Foundation

struct SettingsRow: View {
    let imageName: String
    let title: String
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(title)
                    .font(.sfProDisplay(.medium, size: 19))
                Spacer()
            }
            .frame(height: 70)
            .padding(.horizontal)
            .background(background)
            .cornerRadius(24)
        }
        .buttonStyle(.plain)
    }
}

