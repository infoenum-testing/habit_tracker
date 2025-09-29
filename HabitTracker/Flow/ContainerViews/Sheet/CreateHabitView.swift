//
//  CreateHabitView.swift
//  HabitTracker
//
//  Created by IE14 on 29/09/25.
//

import SwiftUI

struct CreateHabitView: View {
    
   // let habit: HabitTemplate
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    @State private var selectedIcon: String = StringConstants.Image.iconClock
    @State private var selectedColor: String = "color.purple"
    @State private var profileText = ""
    @State private var inputText: String = ""
    @State private var textWidth: CGFloat = 100 // minimum width


    
    private let colorsArray: [String] = AppColors.all
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
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
                }
                .frame(height: 50)
                .padding(.vertical, 30)
                HStack {
                           Spacer()
                           ZStack(alignment: .bottom) {
                               // The TextField
                               TextField("Enter text", text: $inputText)
                                   .font(Font.inter(size: 24, weight: .bold))
                                   .multilineTextAlignment(.center)
                                   .foregroundColor(.white)
                                   .tint(.white)
                                   .background(
                                       // Hidden text to measure width
                                       Text(inputText.isEmpty ? " " : inputText)
                                           .font(Font.inter(size: 24, weight: .bold))
                                           .background(GeometryReader { geo in
                                               Color.clear.onAppear {
                                                   textWidth = max(100, geo.size.width) // minimum 40
                                               }
                                               .onChange(of: inputText) { _ in
                                                   textWidth = max(100, geo.size.width)
                                               }
                                           })
                                           .hidden()
                                   )

                               // Underline
                               Rectangle()
                                   .frame(width: textWidth, height: 1)
                                   .foregroundColor(.white.opacity(0.6))
                                   .offset(y: 10)
                           }
                           Spacer()
                       }
                       .frame(height: 40) // TextField height
                       .padding(.bottom, 25)
                
                HStack(alignment: .top) {
                    
                    TextField("Enter habit’s description", text: $profileText,  axis: .vertical)
                        .lineLimit(.none)
                        .padding(10)
                        .tint(.white)
                    
                }
                .frame(height: 100, alignment: .topLeading)
                .background(.white.opacity(0.06))
                .cornerRadius(11)
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                
                Spacer()
                
                ShareProgressButton(title: StringConstants.Sheet.addHabit, buttonAction:  {
//                    appData.subscribeToHabit(to: habit) { result in
//                        switch result {
//                        case .success(_):
//                            appData.updateSubscribedHabit(
//                                habitID: habit.wrappedId,
//                                icon: selectedIcon,
//                                newThemeColor: selectedColor
//                            ) { success in
//                                dismiss()
//                            }
//                        case .failure(let error):
//                            appData.toastMessage = error.localizedDescription
//                            appData.showToast = true
//                            appData.toastType = .alert
//                        }
//                    }
                }, shouldShowArrow: false)
                .padding(.horizontal, 20)
               
            }
        }
        .frame(height: 400)
    }
}
