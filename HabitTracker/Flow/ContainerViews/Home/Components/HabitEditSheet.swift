//
//  HabitEditSheet.swift
//  HabitTracker
//
//  Created by Apple on 28/08/25.
//

import SwiftUI

struct HabitEditSheet: View {
    @State private var selectedIcon: String = ""
    @State private var selectedColor: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appData: AppDataStore
    
    private let colorsArray: [String] = AppColors.all
    
    // set your preferred content height
    private let preferredHeight: CGFloat = 800
    let deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geo in
            //let deviceHeight = geo.size.height
            let shouldScroll = deviceHeight < preferredHeight
            
            Group {
                if shouldScroll {
                    ScrollView(.vertical, showsIndicators: false) {
                        content
                    }
                } else {
                    content
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.sheetBackgroundColor)
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 5)
                    .background(.white.opacity(0.2))
                    .cornerRadius(3)
                    .padding(.vertical)
                Spacer()
            }
            
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
                selectedColor: $selectedColor,
                action: { }
            )
            
            ShareProgressButton(title: "Save habit") {
                if let habitId = appData.selectedHabitToDelete?.wrappedId {
                    appData.updateSubscribedHabit(
                        habitID: habitId,
                        icon: selectedIcon,
                        newThemeColor: selectedColor
                    ) { _ in
                        dismiss()
                    }
                }
            }
            .padding(.vertical, 26)
            
            Button {
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
        .onAppear {
            if let habit = appData.selectedHabitToDelete {
                selectedIcon = habit.wrappedIcon
                selectedColor = habit.wrappedThemeColor
            }
        }
    }
}

#Preview {
    HabitEditSheet()
}
