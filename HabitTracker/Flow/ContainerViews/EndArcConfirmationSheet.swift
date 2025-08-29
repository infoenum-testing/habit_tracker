//
//  EndArcConfirmationSheet.swift
//  HabitTracker
//
//  Created by IE14 on 19/08/25.
//

import SwiftUI

struct EndArcConfirmationSheet: View {
    @EnvironmentObject var appData: AppDataStore

    @Binding var isPresented: Bool
    var arcName: String
    
    var body: some View {
        VStack() {
            // header (x button)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 5)
                .background(.white.opacity(0.2))
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
                // .background(.red)
                
                Text("Are you sure you want\n to end this Arc!")
                    .font(.sfProDisplay(.semibold, size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }.padding(.horizontal)
            
            
            VStack{
            
            Image("trash")
                .resizable()
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("You will lose all your progress on\n\(arcName)")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top,20)
            }.padding(.vertical,20)
            
            // End Arc Button
            Button {
                if let arcToDelete = appData.selectedArctoDelete {
                    appData.deleteArc(arcToDelete)
                    isPresented = false
                }
            } label: {
                HStack {
                    Image("circleBan")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("End Arc")
                        .font(.sfProDisplay(.semibold, size: 20))
                        .foregroundStyle(.appRed)
                        
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.redDark)
                .cornerRadius(22)
            }
            .padding(.horizontal)
            //.padding(.vertical)
            
            // Cancel Button
            ShareProgressButton(title: "Cancel",buttonAction: {
                // handle share action
            })
            .padding(.horizontal)
            .padding(.top, 10)
        }
       // .background(.sheetBackground)
        .ignoresSafeArea()
        //.padding(.bottom, 20)
    }
}

//
//struct EndArcConfirmationSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        EndArcConfirmationSheet(isPresented: .constant(true),
//                                arcName: "Gut Health Arc")
//            .preferredColorScheme(.dark)
//    }
//}
