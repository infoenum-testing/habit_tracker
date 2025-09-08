//
//  EndArcConfirmationSheet.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 19/08/25.
//

import SwiftUI

struct EndArcConfirmationSheet: View {
    @EnvironmentObject var appData: AppDataStore
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var navigation: NavigationRouter
    @Binding var isPresented: Bool
    var arcName: String
    
    var body: some View {
        VStack() {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 5)
                .background(.white.opacity(0.11))
                .cornerRadius(3)
            
            ZStack(alignment: .top) {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                        
                    }) {
                        HStack {
                            Image(systemName: "xmark")
                                .font(.title3)
                                .padding(8)
                                .foregroundStyle(.white)
                        } .frame(width: 40, height: 40)
                            .background(.white.opacity(0.1))
                            .cornerRadius(20)
                    }
                }
                
                Text(StringConstants.Aleart.endThisArcAlert)
                    .font(.sfProDisplay(.semibold, size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }.padding(.horizontal)
            
            
            VStack{
            
                Image(StringConstants.Image.trash)
                .resizable()
                .resizable()
                .frame(width: 100, height: 100)
            
                Text("\(StringConstants.Sheet.youWillLoseAllYour)\n\(arcName)")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top,20)
            }.padding(.vertical,20)
            
            // End Arc Button
            Button {
                if let arc = appData.selectedArctoDelete {
                    if let _ = appData.saveHistory(for: arc, status: .endByUser){
                        appData.deleteArc(arc)
                        dismiss()
                        navigation.pop()
                        navigation.dismissAll()
                    }
                    
                }
            } label: {
                HStack {
                    Image(StringConstants.Image.circleBan)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(StringConstants.Sheet.endArc)
                        .font(.sfProDisplay(.semibold, size: 20))
                        .foregroundStyle(.appRed)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.redDark)
                .cornerRadius(22)
            }
            .padding(.horizontal)
            
            ShareProgressButton(title: StringConstants.Common.cancel, buttonAction: {
                dismiss()
            }, shouldShowArrow: false)
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .ignoresSafeArea()
    }
}
