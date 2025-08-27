//
//  HabitCustomizationSheet.swift
//  HabitTracker
//
//  Created by ie15 on 26/08/25.
//

import SwiftUI

struct HabitCustomizationSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedColor: Color = .appPurple
    
    private let colors: [Color] = [
        .appGreen, .appPurple, .appRed, .appOrange, .appYellow,
        .appBlue, .appPink, .appCyan, .appTan, .appBrown, .appWhite, .appGray
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                
                HeaderSection(dismiss: dismiss)
                
                DashedLine()
                
                HabitPreviewSection()
                    .padding(.top, 24)
                    .padding(.horizontal, 20)
                
                IconGridView()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 26)
                
                ColorPickerSection(
                    colors: colors,
                    selectedColor: $selectedColor
                )
                .padding(.horizontal, 20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(
            LinearGradient(
                colors: [.appPurple.opacity(0.55), .black, .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// MARK: - Header Section
private struct HeaderSection: View {
    let dismiss: DismissAction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundBackButton(backgroundColor: .black.opacity(0.65)) {
                dismiss()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Brush & Floss")
                    .font(Font.sfPro(size: 38, weight: .semibold))
                    .foregroundStyle(.white)
                
                Text("Brush and floss your teeth today")
                    .font(Font.sfPro(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Habit Preview
private struct HabitPreviewSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Preview Habit")
                .font(Font.sfPro(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            DailyHabitsCellView(icon: "teeth")
        }
    }
}

// MARK: - Color Picker
private struct ColorPickerSection: View {
    let colors: [Color]
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("Change Theme")
                .font(Font.sfPro(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 6), spacing: 16) {
                ForEach(colors, id: \.self) { color in
                    ColorSelectionButton(
                        color: color,
                        isSelected: color == selectedColor
                    ) {
                        selectedColor = color
                    }
                }
            }
        }
    }
}

// MARK: - Color Selection Button
private struct ColorSelectionButton: View {
    let color: Color
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(width: 48, height: 48)
                .cornerRadius(19)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
                )
            
            if isSelected {
                Image("check")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    HabitCustomizationSheet()
}
