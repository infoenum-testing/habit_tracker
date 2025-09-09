//
//  DatePill.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct DatePill: View {
    @EnvironmentObject var appData : AppDataStore
    
    let date: Date
    let isSelected: Bool
    let isPast: Bool
    let width: CGFloat = UIScreen.main.bounds.width / 5 - 10
    
    var body: some View {
        VStack(spacing: 2) {
            Text(date.dayString())
                .font(.sfProDisplay(.bold, size: 28))
                .foregroundColor(isSelected ? .white : .appGray)
            
            Text(date.weekdayShort())
                .font(.sfProDisplay(.bold, size: 14))
                .foregroundColor(isSelected ? .white : .appGray)
            
            if isSelected {
                VStack(spacing: 1) {
                    ForEach(appData.allSubscribedArcs.prefix(3)) { arc in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(ColorToken.from(string: arc.wrappedThemeColor))
                            .frame(width: 18, height: 4)
                    }
                }
                .id(appData.allSubscribedArcs.map(\.wrappedThemeColor).joined()) // key on colors
                
                .padding(2)
            }
        }
        .foregroundStyle(.white)
        .frame(width: width, height: 90)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .stroke(isSelected ? .white : .appGray, lineWidth: isSelected ? 2 : 1)
        )
    }
}
