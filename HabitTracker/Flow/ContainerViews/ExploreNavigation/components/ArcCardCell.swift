//
//  ArcCardCell.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct ArcCardCell: View {
    let arc: ArcTemplate
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                // Background image
                Image(arc.coverImage ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.width)
                    .clipped()
                
                
                // Content overlay
                VStack(alignment: .leading) {
                    // Top badges
                    HStack(spacing: 8) {
                        Text("\(arc.durationDays) Days")
                            
                            .foregroundColor(.white)
                            .font(Font.inter(size: 10))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(20)
                            
                        if let count = arc.habits?.count {
                            Text("\(count) Habits")
                                .foregroundColor(.white)
                                .font(Font.inter(size: 10))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(20)
                        }
                        
                        
                       
                    }
                    Spacer()
                    
                    // Bottom text
                    VStack(alignment: .leading, spacing: 4) {
                        Text(arc.title ?? "")
                            .multilineTextAlignment(.leading)
                            .font(Font.inter(size: 18, weight: .semibold))
                            .foregroundColor(.white.opacity(0.75))
                        
                        Text(arc.descriptionText ?? "")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
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
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(ColorToken.from(string: arc.colorToken ?? "white") , lineWidth: 1)
                    
            }
        }
    }
}

//#Preview {
//    ArcCardCell(arc: arc)
//        .frame(width: 197)
//}
