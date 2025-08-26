//
//  TextBadgeView.swift
//  HabitTracker
//
//  Created by ie15 on 25/08/25.
//

import SwiftUI

struct TextBadgeView: View {
    var title: String = "60 Days"
    var foregroundColor: Color = Color.black
    var icon: String?
    var body: some View {
        HStack(alignment: .center){
            if let icon = icon, !icon.isEmpty {
                Image(icon)
                    .resizable()
                    .foregroundStyle(Color.black)
                    .frame(width: 12, height: 12)
            }
            Text(title)
                .foregroundStyle(foregroundColor)
                .font(Font.sfPro(size: 14))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        
        
    }
}

#Preview {
    TextBadgeView()
}

struct TextBadgeViewForGutHealth: View {
    
    var title: String = "60 Days"
    var foregroundColor: Color = Color.black
    var icon: String?
    var body: some View {
        HStack(alignment: .center){
            if let icon = icon, !icon.isEmpty {
                Image(icon)
                    .resizable()
                    .frame(width: 12, height: 12)
            }
            Text(title)
                .foregroundStyle(foregroundColor)
                .font(Font.sfPro(size: 14))
        }
        .padding(.vertical, 8)
        .padding(.leading, 9)
        .padding(.trailing, 11)
        
        
    }
}
