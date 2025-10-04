//
//  HabitEditSheet.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 28/08/25.
//

import SwiftUI

struct HabitEditSheet: View {
    @State private var selectedIcon: String = ""
    @State private var selectedColor: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appData: AppDataStore
    
    private let colorsArray: [String] = AppColors.all
    
    // set your preferred content height
    private let preferredHeight: CGFloat = 500
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
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(AppIcons.all, id: \.self) { icon in
                            let isSelected = icon == selectedIcon
                            let width: CGFloat = isSelected ? 50 : 34
                            let height: CGFloat = isSelected ? 50 : 34
                            VStack {
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .opacity(isSelected ? 1 : 0.40)
                            }
                            .frame(width: width, height: height)
                            .background(Color.white.opacity(0.10))
                            .cornerRadius(width / 2)
                            .background(
                                Circle()
                                    .strokeBorder(Color.white, lineWidth: selectedIcon == icon ? 3 : 0)
                            )
                            .id(icon)
                            .onTapGesture {
                                withAnimation {
                                    selectedIcon = icon
                                    proxy.scrollTo(icon, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .task {
                    if let habit = appData.selectedHabitToDelete {
                        selectedIcon = habit.wrappedIcon
                        selectedColor = habit.wrappedThemeColor
                  //  selectedIcon = habit.icon
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            proxy.scrollTo(selectedIcon, anchor: .center)
                        }
                    }
                }
                }
            }
            .frame(height: 50)
            .padding(.vertical, 30)
            
//            ColorPickerSection(
//                colors: colorsArray,
//                selectedColor: $selectedColor,
//                action: { }
//            )
            
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(AppColors.all, id: \.self) { icon in
                            let isSelected = icon == selectedColor
                            let width: CGFloat = isSelected ? 60 : 40
                            let height: CGFloat = isSelected ? 60 : 40
                            VStack {
                                Circle()
                                    .fill(ColorToken.from(string: icon))
                                    .frame(width: isSelected ? 36 : 30, height: isSelected ? 36 : 30)
                            }
                            .frame(width: width, height: height)
                            .background(Color.white.opacity(0.10))
                            .cornerRadius(width / 2)
                            .background(
                                Circle()
                                    .strokeBorder(Color.white, lineWidth: selectedColor == icon ? 3 : 0)
                            )
                            .id(icon)
                            .onTapGesture {
                                withAnimation {
                                    selectedColor = icon
                                    proxy.scrollTo(icon, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .task {
                    if let arc = appData.selectedArctoDelete {
                        selectedColor = arc.wrappedThemeColor
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo(selectedColor, anchor: .center)
                            }
                        }
                    }
                }
            }
            
            ShareProgressButton(title: StringConstants.Sheet.saveHabit) {
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
