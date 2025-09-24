//
//  ExploreHeaderView.swift
//  HabitTracker
//
//  Created by IE14 on 24/09/25.
//

import SwiftUI

struct ExploreHeaderView: View {
    
    @Binding var isArkSelected: Bool
    var body: some View {
        VStack(spacing: 20) {
            Text(StringConstants.ExploreNavigation.explore)
                .font(Font.inter(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .top)
            
            HStack(alignment: .center) {
                
                Button(action: {
                    withAnimation {
                        isArkSelected = true
                    }
                }) {
                    HStack {
                        Image(StringConstants.Image.arcIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundColor(isArkSelected ? .black : .white)
                        
                        Text(StringConstants.ExploreNavigation.arcs)
                            .font(Font.sfProDisplay(.semibold, size: 16))
                            .foregroundColor(isArkSelected ? .black : .white)

                    }.padding(.horizontal, 25)
                     .padding(.vertical, 8)
                     .background(Capsule().fill(isArkSelected ? Color.white : .clear))
                }

                Button(action: {
                    withAnimation {
                        isArkSelected = false
                    }
                }, label: {
                    HStack {
                        Image(StringConstants.Image.habitIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 8)
                            .foregroundColor(isArkSelected ? .white : .black)
                        
                        Text(StringConstants.ExploreNavigation.habits)
                            .font(Font.sfProDisplay(.semibold, size: 16))
                            .foregroundColor(isArkSelected ? .white : .black)

                    }.padding(.horizontal, 25)
                     .padding(.vertical, 8)
                     .background(Capsule().fill(isArkSelected ? .clear : Color.white))

                })
                
            }
            .padding(2)
            .frame(height: 39, alignment: .leading)
            .background(.white.opacity(0.04))
            .cornerRadius(26)
        }
    }
}
