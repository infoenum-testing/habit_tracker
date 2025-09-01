//
//  HabitEditSheet.swift
//  HabitTracker
//
//  Created by Apple on 28/08/25.
//

import SwiftUI

struct HabitEditSheet: View {
    
    @State private var selectedIcon: String = "figure.walk"
    @State private var selectedColor: String = "color.purple"
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appData: AppDataStore
    
    private let colorsArray: [String] = AppColors.all
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                RoundBackButton(backgroundColor: .black.opacity(0.65)) {
                    dismiss()
                }
                Spacer()
                Text("Edit Habit")
                    .foregroundStyle(.white)
                    .font(Font.sfPro(size: 20, weight: .medium))
                Spacer()
                
                Circle()
                    .fill(Color.clear)
                    .frame(width: 40, height: 40)
            }
            
            IconGridView(color: ColorToken.from(string: selectedColor), icon: $selectedIcon)
                .padding(.vertical, 26)
            
            ColorPickerSection(
                colors: colorsArray,
                selectedColor: $selectedColor, action: {
                    
                }
            )
            
            ShareProgressButton(title: "Save habit") {
                if let habitId = appData.selectedHabitToDelete?.wrappedId {
                    appData.updateSubscribedHabit(
                        habitID: habitId,
                        icon: selectedIcon,
                        newThemeColor: selectedColor
                    ) { _ in
                        // completion
                        dismiss()
                    }
                }
            }

            .padding(.vertical, 26)
            
            Button {
                // action
                if let habit = appData.selectedHabitToDelete {
                    appData.deleteHabit(habit)
                    dismiss()
                }
            } label: {
                HStack {
                    Image("circleBan")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 15)
                    Text("End Habit")
                        .font(.sfProDisplay(.medium, size: 20))
                        .foregroundColor(.appRed)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.redDark)
                .cornerRadius(22)
            }
            .padding(.bottom, 26)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .background(Color.sheetBackgroundColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
    }
}

#Preview {
    HabitEditSheet()
}
