//
//  RoundBackButton.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 26/08/25.
//

import SwiftUI

struct RoundBackButton: View {
    var icon: String = StringConstants.Image.arrowLeft
    var iconColor: Color = .black
    var backgroundColor: Color = .white.opacity(0.07)
    let action: () -> Void
    var body: some View {
        
        HStack(alignment: .center, spacing: 8) {
            Button(action: {
                action()
            }) {
                Image(icon)
                    .resizable()
                    .foregroundColor(iconColor)
                    .frame(width: 25, height: 25)
            }
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(55)
    }
}

#Preview {
    RoundBackButton(){
        
    }
}
