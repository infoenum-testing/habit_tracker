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
                .padding(.top, 10)
            
            HStack {
                RoundBackButton(backgroundColor: .black.opacity(0.65)) {
                    isPresented = false
                }
                Spacer()
                Text(StringConstants.Sheet.editArc)
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 30)
            }.frame(height: 50)
                .padding(.vertical,10)
            ColorPickerSection(
                colors: colorsArray,
                selectedColor: $selectedColor,
                action: { }
            )
            ShareProgressButton(title: StringConstants.Sheet.saveArc) {
                appData.updateSubscribedArc(arcId: appData.selectedArctoDelete?.wrappedId ?? "", icon: nil, newThemeColor: selectedColor) { _ in
                    dismiss()
                }
            }
            .padding(.vertical, 25)
            
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
        }.ignoresSafeArea()
            .padding(.horizontal,20)
            .task {
                if let arc = appData.selectedArctoDelete {
                    selectedColor = arc.wrappedThemeColor
                }
            }
        
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
