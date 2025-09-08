//
//  HabitCustomizationSheet.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 26/08/25.
//

import SwiftUI

struct HabitCustomizationSheet: View {
    let habit: HabitTemplate
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    @State private var selectedIcon: String = StringConstants.Image.iconClock
    @State private var selectedColor: String = "color.purple"
    
    private let colorsArray: [String] = AppColors.all
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 100, height: 5)
                        .background(.white.opacity(0.11))
                        .cornerRadius(3)
                        .padding(.vertical)
                    Spacer()
                }
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
                    ShareProgressButton(title: StringConstants.Sheet.saveHabit) {
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
                    .padding(.top, 25)
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
