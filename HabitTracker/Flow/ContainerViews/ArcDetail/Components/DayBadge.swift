//
//  DayBadge.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct DayBadge: View { let day: Int; var body: some View {
    VStack(spacing: 2) {
        Text("DAY")
            .font(.sfProDisplay(.bold, size: 10))
            .opacity(0.8)
        Text("\(day)")
            .font(.sfProDisplay(.bold, size: 30))
        
    }.frame(width: 73, height: 78)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color(UIColor.white), lineWidth: 2)
        )
        .foregroundStyle(.white)
}}

