//
//  SelectionOptionCellView.swift
//  HabitTracker
//
//  Created by ie13 on 30/09/25.
//

import SwiftUI

struct SelectionOptionCellView: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let buttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.10)) // Background color
                    .frame(width: 56, height: 56)
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.appCyan : Color.white.opacity(0.10), lineWidth: 2)
                    )

                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSelected ? .green : .white)
            }
            
            Text(title)
                .font(.inter(size: 16, weight: .semibold))
                .foregroundColor(.white)
        }
        .onTapGesture {
            buttonAction()
        }
    }
}
