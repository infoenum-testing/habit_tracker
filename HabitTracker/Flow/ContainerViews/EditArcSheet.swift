//
//  EditArcSheet.swift
//  HabitTracker
//
//  Created by IE14 on 19/08/25.
//

import SwiftUI

struct EditArcSheet: View {
    @Binding var isPresented: Bool
    @State private var selectedColor: Color = .purple
    @State private var showConfirmation = false

    
    private let colors: [Color] = [
        .green, .purple, .red, .orange, .yellow,
        .blue, .pink, .mint, .gray
    ]
    
    var body: some View {
        VStack {
            Spacer()
        VStack(spacing: 10) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 103.70827, height: 5.7)
              .background(.white.opacity(0.3))
              .cornerRadius(3.42)
              .padding(.vertical)
            // Header
            HStack {
                
//                CircleButton(icon: "back") {
//                    isPresented = false
//                }
                
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
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5), spacing: 16) {
                    ForEach(colors, id: \.self) { color in
                        ZStack {
                            
                            Rectangle()
                                .fill(color)
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
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
            .padding(.bottom, 20)
        }
        .frame(height: 420)
        .background(.sheetBackground)
        .cornerRadius(30)
        }.ignoresSafeArea()
            .sheet(isPresented: $showConfirmation) {
                EndArcConfirmationSheet(isPresented: $showConfirmation,
                                        arcName: "Gut Health Arc")
                    .presentationDetents([.fraction(0.60)])
                    .presentationCornerRadius(24)
                    .presentationBackground {
                        Color(UIColor.systemBackground)
                    }
                   
                    
            }

    }
}


struct EditArcSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditArcSheet(isPresented: .constant(true))
            .preferredColorScheme(.dark) // remove this if you want light mode
    }
}
