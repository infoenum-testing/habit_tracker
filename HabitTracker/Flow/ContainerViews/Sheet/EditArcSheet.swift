//
//  EditArcSheet.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 19/08/25.
//

import SwiftUI

struct EditArcSheet: View {
    @Binding var isPresented: Bool
    @State private var selectedColor: String = ""
    @State private var showConfirmation = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var navigation: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    let arcId: String = ""
    let habitId: String = ""
    
    private let colorsArray: [String] = AppColors.all
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 5)
                .background(.white.opacity(0.11))
                .cornerRadius(3)
                .padding(.top, 20)
            
            HStack {
                RoundBackButton(iconColor: .white,backgroundColor: .black.opacity(0.65), action: {
                    isPresented = false
                })
                Spacer()
                Text(StringConstants.Sheet.editArc)
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 30)
            }.frame(height: 50)
                .padding(.vertical,10)
                .padding(.horizontal,20)
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
            
            
            
            
            ShareProgressButton(title: StringConstants.Sheet.saveArc) {
                appData.updateSubscribedArc(arcId: appData.selectedArctoDelete?.wrappedId ?? "", icon: nil, newThemeColor: selectedColor) { _ in
                    dismiss()
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal,20)
            
            Button {
                showConfirmation = true
            } label: {
                HStack {
                    Image(StringConstants.Image.circleBan)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 15)
                    Text(StringConstants.Sheet.endArc)
                        .font(.sfProDisplay(.medium, size: 20))
                        .foregroundColor(.appRed)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.redDark)
                .cornerRadius(22)
            }
            .padding(.bottom, 25)
            .padding(.horizontal,20)
        }.ignoresSafeArea()
            
//            .task {
//                if let arc = appData.selectedArctoDelete {
//                    selectedColor = arc.wrappedThemeColor
//                }
//            }
        
            .sheet(isPresented: $showConfirmation) {
                EndArcConfirmationSheet(isPresented: $showConfirmation,
                                        arcName: StringConstants.Sheet.gutHealthArc)
                .presentationDetents([.height(500)])
                .presentationCornerRadius(24)
                .presentationBackground {
                    Color(UIColor.systemBackground)
                }
            }
            .onChange(of: navigation.dismissAllSheets, perform: { newValue in
                dismiss()
            })
    }
}


struct EditArcSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditArcSheet(isPresented: .constant(true))
            .preferredColorScheme(.dark)
    }
}




//    .sheet(item: $selectedHabit) { habit in
//        HabitCustomizationSheet(habit: habit)
//            .presentationDetents([.large])
//        //.presentationDragIndicator(.visible)
//            .presentationCornerRadius(45)
//    }
