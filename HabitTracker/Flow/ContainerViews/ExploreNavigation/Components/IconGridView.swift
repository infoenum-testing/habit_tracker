//
//  IconGridView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 26/08/25.
//

import SwiftUI

struct IconGridView: View {
   
    let icons: [String] = AppIcons.all
    var color: Color
    @Binding var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 27) {
            Text(StringConstants.ExploreNavigation.changeIcon)
                .font(Font.sfPro(size: 16, weight: .medium))
            .foregroundColor(.white)
            LazyVGrid(columns: Array(repeating: GridItem(), count: 8)) {
                ForEach(0..<icons.count, id: \.self) { index in
                    let iconName = icons[index]
                    ZStack {
                        Circle()
                            .opacity(0.0)
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(Color.white, lineWidth: 2)
                            .opacity(iconName == icon ? 1 : 0)
                        Image(iconName)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(iconName == icon ? .white : color)
                            
                    }
                    .foregroundStyle(color)
                    .onTapGesture {
                        icon = iconName
                    }
                }
            }
        }
        
    }
}

#Preview {
    IconGridView(color: .appRed, icon: .constant("figure.walk"))
}
