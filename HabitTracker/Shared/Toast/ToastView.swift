//
//  ToastView.swift
//  HabitTracker
//
//  Created by DRT on 06/10/25.
//


import SwiftUI

struct ToastView: View {
    @Binding var isShown: Bool
    var message: String
    var alignment: Alignment = .top
    
    var body: some View {
        if isShown {
            VStack {
                Spacer()
                HStack(spacing: 27) {
                    Image(.greenCheckMark)
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                    Text(message)
                        .font(.inter(size: 15, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color._1_C_1_C_1_C)
                .cornerRadius(14)
                .shadow(color: Color.brightGreen.opacity(0.5), radius: 12, x: 0, y: 12)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .inset(by: 1.5)
                        .stroke(Color(red: 0.01, green: 0.95, blue: 0.63), lineWidth: 3)
                )
            }
            .padding(.bottom, 40)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}
