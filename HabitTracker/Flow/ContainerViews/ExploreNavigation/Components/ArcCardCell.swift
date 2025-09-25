//
//  ArcCardCell.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 22/08/25.
//

import SwiftUI

struct ArcCardCell: View {
    let arc: ArcTemplate
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Image(StringConstants.Image.card)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.width)
                    .clipped()
                // Content overlay
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        // Top badges
                        HStack(spacing: 2) {
                            Spacer()
                            HStack(spacing: 5) {
                                Image(StringConstants.Image.timeCircle)
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.white)
                                
                                Text("\(arc.durationDays) \(arc.durationDays == 1 ? StringConstants.ExploreNavigation.daySingular : StringConstants.ExploreNavigation.dayPlural)")
                                    .foregroundColor(.white)
                                    .font(Font.inter(size: 10))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            if let count = arc.habitsData?.count {
                                HStack(spacing: 5) {
                                    Image(StringConstants.Image.arc)
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.white)
                                    
                                    Text("\(count) \(count == 1 ? StringConstants.ExploreNavigation.habitSingular : StringConstants.ExploreNavigation.habitPlural)")
                                    
                                        .foregroundColor(.white)
                                        .font(Font.inter(size: 10))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                            
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical)
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        
                        if let title = arc.title {
                            Text(arcFormatted: title, fontSize: 18)
                                .multilineTextAlignment(.leading)
                                .font(Font.inter(size: 18, weight: .semibold))
                                .foregroundColor(.white.opacity(0.75))
                        }
                        Text(arc.shortSubtitle ?? "")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(Font.inter(size: 13))
                            .foregroundColor(.white.opacity(0.75))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial.opacity(0.15))
                }
            }
            .frame(width: geo.size.width, height: geo.size.width, alignment: .center)
            .cornerRadius(20)
            .clipped()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.4)
                    .stroke(ColorToken.from(string: arc.colorToken ?? "white") , lineWidth: 1)
                
            }
        }
    }
}

struct NewArcsCell: View {
    let arc: ArcTemplate
    
    var body: some View {
        ZStack {
            
            Image(StringConstants.Image.card)
                .resizable()
                .scaledToFill()
                .clipped()
            
            VStack() {
                if let title = arc.title {
                    Text(arcFormatted: title, fontSize: 18, arcColor:  ColorToken.from(string: arc.colorToken ?? "yellow") , titleColor: .white)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
                
                
                HStack {
                    HStack {
                        Image(StringConstants.Image.timeCircle)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.white)
                        
                        Text("\(arc.durationDays) \(arc.durationDays == 1 ? StringConstants.ExploreNavigation.daySingular : StringConstants.ExploreNavigation.dayPlural)")
                            .foregroundColor(.white)
                            .font(Font.inter(size: 10, weight: .medium))
                            .lineLimit(1)
                            
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial.opacity(0.5))
                    .cornerRadius(12)
                    .overlay(
                     RoundedRectangle(cornerRadius: 12)
                    .stroke(ColorToken.from(string: arc.colorToken ?? "white"), lineWidth: 0.5))
                    
                    HStack {
                        HStack(spacing: 1) {
                            ForEach(0..<5) { _ in
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.red)
                                    .frame(width: 1.5, height: 7)
                            }
                        }
                        
                        Text("Easy")
                            .foregroundColor(.white)
                            .font(Font.inter(size: 10, weight: .medium))
                            .lineLimit(1)
                            
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial.opacity(0.5))
                    .cornerRadius(12)
                    
                    Spacer()
                    
                    HStack {
                        
                        Image(StringConstants.Image.userGroup)
                            .resizable()
                            .frame(width: 12, height: 10)
                            .foregroundColor(.white)
                        
                        Text("15, 678  Active Users")
                            .foregroundColor(.white)
                            .font(Font.inter(size: 10))
                            .lineLimit(1)
                            
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial.opacity(0.5))
                    .cornerRadius(12)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.black.opacity(0.1))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .cornerRadius(12)
    }
}



