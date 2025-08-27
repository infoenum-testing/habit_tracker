//
//  IconGridView.swift
//  HabitTracker
//
//  Created by ie15 on 26/08/25.
//

import SwiftUI

struct IconGridView: View {
   
     let icons: [String] = ["figure.walk", "fork.knife", "bed.double.fill", "book.fill", "sun.max.fill", "dumbbell", "music.note", "paintbrush.fill", "bolt.fill", "heart.fill", "leaf.fill", "flame.fill", "hare.fill", "timer", "cup.and.saucer.fill", "brain.head.profile", "waveform.path.ecg", "bubble.left.fill", "trash.fill", "sparkles", "house.fill", "laptopcomputer", "scissors", "gamecontroller.fill", "airplane", "sailboat.fill", "bicycle", "figure.mind.and.body", "party.popper.fill", "snowflake", "fish.fill", "camera.macro"]
    var color: Color
    @Binding var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 27) {
            Text("Change icon")
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
                        Image(systemName: iconName)
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
    IconGridView(color: .appCyan, icon: .constant("figure.walk"))
}
