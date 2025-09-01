//
//  EditArcSheet.swift
//  HabitTracker
//
//  Created by IE14 on 19/08/25.
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
        VStack(spacing: 10) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 100, height: 5)
              .background(.white.opacity(0.2))
              .cornerRadius(3)
              .padding(.vertical)
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    HStack {
                        Image("arrow-left")
                            .font(.title3)
                            .padding(8)
                            .foregroundStyle(.white)
                    } .frame(width: 40, height: 40)
                        .background(.white.opacity(0.1))
                        .cornerRadius(20)
                }
                
               
                Spacer()
                Text("Edit Arc")
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 30)
            }
            .padding(.horizontal)
            
            // Change Theme Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Change Theme")
                    .font(.sfProDisplay(.semibold, size: 18))
                    .padding()
                
                // Color grid
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 6), spacing: 10) {
                    ForEach(colorsArray, id: \.self) { color in
                        ZStack {
                            
                            Rectangle()
                                .fill(ColorToken.from(string: color))
                                .frame(width: 48, height: 48)
                                .cornerRadius(19)
                                .padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 19)
                                        .stroke(color == selectedColor ? Color.white : Color.clear, lineWidth: 2)
                                )
                            
                            if color == selectedColor {
                                Image("check")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            selectedColor = color
                            print("Selected color: \(color)")
                             
                            appData.updateSubscribedArc(arcId: appData.selectedArctoDelete?.wrappedId ?? "", icon: nil, newThemeColor: color) { _ in
                                print("Arc color updated successfully")
                                dismiss()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // End Arc button
            Button {
                // action
                showConfirmation = true
            } label: {
                HStack {
                    Image("circleBan")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 15)
                    Text("End Arc")
                        .font(.sfProDisplay(.medium, size: 20))
                        .foregroundColor(.appRed)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.redDark)
                .cornerRadius(22)
                
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }.ignoresSafeArea()
            .sheet(isPresented: $showConfirmation) {
                EndArcConfirmationSheet(isPresented: $showConfirmation,
                                        arcName: "Gut Health Arc")
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
            .preferredColorScheme(.dark) // remove this if you want light mode
    }
}
