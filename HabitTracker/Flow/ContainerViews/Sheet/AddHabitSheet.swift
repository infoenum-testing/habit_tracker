//
//  AddHabitSheet.swift
//  HabitTracker
//
//  Created by IE14 on 26/09/25.
//

import SwiftUI

struct AddHabitSheet: View {
    
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
                        .frame(width: 119, height: 5)
                        .background(.white.opacity(0.2))
                        .cornerRadius(15)
                    Spacer()
                }
                .padding(.top,19)
                
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
                    .onAppear {
                        // ensure habit icon is set first
                        selectedIcon = habit.wrappedIcon
                        
                        // scroll AFTER a tiny delay (so layout is ready)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo(selectedIcon, anchor: .center)
                            }
                        }
                    }
                }
                .frame(height: 50)
                .padding(.vertical, 30)
                
                HStack {
                    Spacer()
                    Text(habit.wrappedTitle)
                        .font(Font.inter(size: 24, weight: .bold))
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.2))
                                .cornerRadius(9)
                                .offset(y: 10)
                        }
                    Spacer()
                }
                .frame(height: 33)
                .padding(.bottom,25)
                
                VStack {
                    HStack(alignment: .top, spacing: 10) {
                        Text(habit.wrappedDetails)
                            .font(Font.inter(size: 12, weight: .light))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(.white.opacity(0.06))
                    .cornerRadius(11)
                }
                .padding(.horizontal)
                .padding(.bottom,50)
                
                ShareProgressButton(title: StringConstants.Sheet.addHabit, buttonAction:  {
                    appData.subscribeToHabit(to: habit) { result in
                        switch result {
                        case .success(_):
                            appData.updateSubscribedHabit(
                                habitID: habit.wrappedId,
                                icon: selectedIcon,
                                newThemeColor: selectedColor
                            ) { success in
                                dismiss()
                            }
                        case .failure(let error):
                            appData.toastMessage = error.localizedDescription
                            appData.showToast = true
                            appData.toastType = .alert
                        }
                    }
                }, shouldShowArrow: false)
                .padding(.horizontal, 20)
                
//                ShareProgressButton(title: StringConstants.Sheet.saveArc) {
//                    appData.updateSubscribedArc(arcId: appData.selectedArctoDelete?.wrappedId ?? "", icon: nil, newThemeColor: selectedColor) { _ in
//                        dismiss()
//                    }
//                }
//                .padding(.vertical, 25)
                
                Spacer()
            }
        }
        .frame(height: 400)
    }
}
