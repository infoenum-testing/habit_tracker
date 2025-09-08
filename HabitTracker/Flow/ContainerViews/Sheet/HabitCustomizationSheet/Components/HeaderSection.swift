//
//  HeaderSection.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation
import SwiftUI

 struct HeaderSection: View {
    let dismiss: DismissAction
    var habit: HabitTemplate
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundBackButton(backgroundColor: .black.opacity(0.65)) {
                dismiss()
            }
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(habit.title ?? "")
                    .font(Font.sfPro(size: 38, weight: .semibold))
                    .foregroundStyle(.white)
                
                Text(habit.details ?? "")
                    .font(Font.sfPro(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
