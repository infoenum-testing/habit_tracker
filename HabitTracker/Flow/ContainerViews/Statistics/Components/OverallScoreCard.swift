//
//  OverallScoreCard.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import Foundation
import SwiftUI

struct OverallScoreCard: View {
    
    @Binding var showInfoPopup: Bool
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 0) {
                
                Button(action: {
                    withAnimation {
                        showInfoPopup.toggle()
                    }
                }){
                    HStack {
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.white.opacity(0.5))
                    
                }.padding(.trailing, 15)
            }
                
                HStack(spacing: 11) {
                    VStack {
                        Image(StringConstants.Image.powerLevelIcon)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                            .padding()
                    }
                    .frame(width: 32, height: 32)
                    .background(.appGray)
                    .cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(StringConstants.Account.logo)
                            .font(.sfProDisplay(.medium, size: 10))
                            .foregroundColor(.gray)
                        Text(StringConstants.Account.powerLevel)
                            .font(.sfProDisplay(.medium, size: 16))
                            .foregroundStyle(.white)
                    }
                }
                
                HStack(spacing: 0) {
                    Text("0")
                        .foregroundStyle(.gray)
                    Text("231")
                        .foregroundStyle(.white)
                    
                }.font(.sfPro(size: 90, weight: .bold))
                
                HStack(spacing: 10) {
                    HStack {
                        
                        Text("+8")
                            .font(.sfPro(size: 12, weight: .medium))
                            .foregroundStyle(.appCyan)
                        
                        ZStack {
                            
                            Circle().fill(Color.appCyan).frame(width: 15, height: 15)
                            
                            Image(StringConstants.Image.chevronRightSmall)
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 8, height: 5)
                        }
                        
                    }.padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color(red: 0.21, green: 0.25, blue: 0.12))
                        .cornerRadius(99)
                    
                    Text("Updated today")
                        .font(.sfPro(size: 14))
                        .foregroundColor(.white.opacity(0.5))

                }
                
            }.padding(.leading, 50)
            
        }.frame(maxWidth: .infinity, minHeight: 235, maxHeight: 235)
            .background(
            LinearGradient(
            stops: [
                Gradient.Stop(color: Color.cardBackgroundColor.opacity(0), location: 0.00),
            Gradient.Stop(color: Color.cardBackgroundColor, location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1.17)
            )
            )
            .cornerRadius(24)
    }
}



