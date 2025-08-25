//
//  ArcCardCell.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct ArcCardCell: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background image
                Image("card")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.width)
                    .clipped()
                
                
                // Content overlay
                VStack(alignment: .leading) {
                    // Top badges
                    HStack(spacing: 8) {
                        Text("45 Days")
                            
                            .foregroundColor(.white)
                            .font(Font.inter(size: 10))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(20)
                            
                        
                        Text("5 Habits")
                            .foregroundColor(.white)
                            .font(Font.inter(size: 10))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(20)
                        
                       
                    }
                    Spacer()
                    
                    // Bottom text
                    VStack(alignment: .leading, spacing: 4) {
                        Text("White Smile Arc")
                            .multilineTextAlignment(.leading)
                            .font(Font.inter(size: 18, weight: .semibold))
                            .foregroundColor(.white.opacity(0.75))
                        
                        Text("Make a Strong First Impression")
                            .multilineTextAlignment(.leading)
                            .font(Font.inter(size: 13))
                            .foregroundColor(.white.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .frame(width: geo.size.width, height: geo.size.width)
            .cornerRadius(20)
            .clipped()
        }
    }
}

#Preview {
    ArcCardCell()
        .frame(width: 197)
}
