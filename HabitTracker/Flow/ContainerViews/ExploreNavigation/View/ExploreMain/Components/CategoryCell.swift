//
//  CategoryCell.swift
//  HabitTracker
//
//  Created by IE14 on 26/09/25.
//


import SwiftUI

struct CategoryCell: View {
    let title: String
    let arcsCount: Int
    let backgroundImage: String
    let width = (UIScreen.main.bounds.width - 60) / 2
    let onTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: 110)
                .clipped()
                .cornerRadius(16)
                .blur(radius: 0.4)
            
            
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear]),
                           startPoint: .bottom,
                           endPoint: .top)
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(title)
                    .font(.sfProDisplay(.medium, size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack {
                    Spacer()
                    Text("\(arcsCount) Arcs")
                        .font(.sfProDisplay(.medium, size: 12))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.appCyan)
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                }
                
            }
            .padding(15)
        }
        .frame(width: width, height: 110)
        .onTapGesture {
            onTap()
        }
    }
}


