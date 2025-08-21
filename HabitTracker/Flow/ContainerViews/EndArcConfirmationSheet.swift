//
//  EndArcConfirmationSheet.swift
//  HabitTracker
//
//  Created by IE14 on 19/08/25.
//

import SwiftUI

struct EndArcConfirmationSheet: View {
    @Binding var isPresented: Bool
    var arcName: String
    
    var body: some View {
        VStack() {
            // header (x button)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 103.70827, height: 5.7)
              .background(.white.opacity(0.3))
              .cornerRadius(3.42)
            
            ZStack(alignment: .top) {
                HStack {
                    Spacer()
                    Button(action: { isPresented = false }) {
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
            
            
           
            
            Image("trash")
                .resizable()
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.vertical)
            
            Text("You will lose all your progress on\n\(arcName)")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // End Arc Button
            Button {
                // end arc action
            } label: {
                HStack {
                    Image(systemName: "slash.circle")
                    Text("End Arc")
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.redDark)
                .foregroundColor(.white)
                .cornerRadius(14)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            // Cancel Button
            ShareProgressButton(title: "Cancel",buttonAction: {
                // handle share action
            })
            .padding(.horizontal)
        }
       // .background(.sheetBackground)
        .ignoresSafeArea()
        //.padding(.bottom, 20)
    }
}


struct EndArcConfirmationSheet_Previews: PreviewProvider {
    static var previews: some View {
        EndArcConfirmationSheet(isPresented: .constant(true),
                                arcName: "Gut Health Arc")
            .preferredColorScheme(.dark)
    }
}
