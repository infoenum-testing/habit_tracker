//
//  ToggleChip.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct ToggleChip: View {
    var icon: String
    var isOn: Bool
    var tap: () -> Void

    var body: some View {
        Button(action: tap) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 28)
                .background(isOn ? .white.opacity(0.12) : .clear)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }.buttonStyle(.plain)
    }
}
