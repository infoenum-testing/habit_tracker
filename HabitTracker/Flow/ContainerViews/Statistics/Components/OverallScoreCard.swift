//
//  OverallScoreCard.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import Foundation
import SwiftUI

struct OverallScoreCard: View {
    
    @EnvironmentObject var appData: AppDataStore
    @Binding var showInfoPopup: Bool
    
    
    // Precompute characters and their colors
      private var digitsWithColors: [(String, Color)] {
          let overall = appData.grandTotals.overall
          let padded = String(format: "%04d", overall)
          var result: [(String, Color)] = []
          var started = false
          for char in padded {
              if started || char != "0" {
                  result.append((String(char), .white))
                  started = true
              } else {
                  result.append((String(char), .gray))
              }
          }
          return result
      }
    
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
                
                HStack {
                    Spacer()
                    HStack(spacing: 0) {
                                ForEach(Array(digitsWithColors.enumerated()), id: \.offset) { _, item in
                                    Text(item.0)
                                        .foregroundStyle(item.1)
                                        .font(.sfPro(size: 90, weight: .bold))
                                }
                            }
                    Spacer()
                }

                if let overall = appData.todayStatistics?.overallTotal, overall > 0 {
                    HStack(spacing: 10) {
                        HStack {
                            
                            Text("+\(overall)")
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
                        
                        Text(StringConstants.Account.updatedDaily)
                            .font(.sfPro(size: 14))
                            .foregroundColor(.white.opacity(0.5))

                    }
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



