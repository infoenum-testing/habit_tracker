//
//  ToastView.swift
//  HabitTracker
//
//  Created by DRT on 06/10/25.
//


import SwiftUI

struct ToastView: View {
    var message: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle")
                .foregroundColor(.green)
            
            Text(message)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.black)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.green, lineWidth: 1)
                .shadow(color: Color.green.opacity(0.8), radius: 10, x: 0, y: 0)
        )
        .cornerRadius(30)
        .padding(.bottom, 40)
    }
}
