//
//  HabitCustomizationSheet.swift
//  HabitTracker
//
//  Created by ie15 on 26/08/25.
//

import SwiftUI

struct HabitCustomizationSheet: View {
    let habit: HabitTemplate
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    @State private var selectedIcon: String = "icon.clock"
    @State private var selectedColor: String = "color.purple"
    
   
    private let colorsArray: [String] = AppColors.all
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView(showsIndicators: false) {
                    HeaderSection(dismiss: dismiss, habit: habit)
                    
                    DashedLine()
                    
                    HabitPreviewSection(color: ColorToken.from(string: selectedColor), icon: selectedIcon, habit: habit)
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                    
                    
                    IconGridView(color: ColorToken.from(string: selectedColor), icon: $selectedIcon)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 26)
                    
                    ColorPickerSection(
                        colors: colorsArray,
                        selectedColor: $selectedColor, action: {
                            
                        }
                    )
                    .padding(.horizontal, 20)
                    ShareProgressButton(title: "Save habit") {
                        appData.subscribeToHabit(to: habit) { result in
                            switch result {
                            case .success(_):
                                appData.updateSubscribedHabit(habitID: habit.wrappedId, icon: selectedIcon, newThemeColor: selectedColor) { success in
                                    dismiss()
                                }
                            case .failure(let error):
                                appData.toastMessage = error.localizedDescription
                                appData.showToast = true
                                appData.toastType = .alert
                            }
                        }
                        
                    }
                    .padding(.top, 26)
                    .padding(.horizontal, 20)
                }
                .toast(isShown: $appData.showToast, title: "", message: appData.toastMessage, type: appData.toastType, alignment: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(
            LinearGradient(
                colors: [ColorToken.from(string: selectedColor).opacity(0.55), .black, .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        
        .onAppear {
            selectedIcon =  habit.wrappedIcon
            selectedColor = habit.wrappedColorToken
        }
    }
}

// MARK: - Header Section
private struct HeaderSection: View {
    let dismiss: DismissAction
    var habit: HabitTemplate
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundBackButton(backgroundColor: .black.opacity(0.65)) {
                dismiss()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(habit.title ?? "")
                    .font(Font.sfPro(size: 38, weight: .semibold))
                    .foregroundStyle(.white)
                
                Text(habit.details ?? "")
                    .font(Font.sfPro(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

// MARK: - Habit Preview
private struct HabitPreviewSection: View {
    var color: Color
    var icon: String
    var habit: HabitTemplate
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Preview Habit")
                .font(Font.sfPro(size: 16, weight: .medium))
                .foregroundColor(.white)
            
                        DailyHabitsCellView(habit: habit, color: color)
        }
    }
}

// MARK: - Color Picker
 struct ColorPickerSection: View {
    let colors: [String]
    @Binding var selectedColor: String
    let action: () -> Void
    
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
                        action()
                    }
                }
            }
        }
    }
}

// MARK: - Color Selection Button
private struct ColorSelectionButton: View {
    let color: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorToken.from(string: color))
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

//#Preview {
//    HabitCustomizationSheet()
//}
