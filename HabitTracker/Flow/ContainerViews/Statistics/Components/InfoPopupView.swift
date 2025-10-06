//
//  InfoPopupView.swift
//  HabitTracker
//
//  Created by ie13 on 26/09/25.
//

import SwiftUI

struct InfoPopupView: View {
    
    @EnvironmentObject var appData: AppDataStore
    @ObservedObject var statisticsViewModel : StatisticsViewModel


    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack(spacing: 0) {
                        ForEach(Array(appData.digitsWithColors.enumerated()), id: \.offset) { _, item in
                            Text(item.0)
                                .foregroundStyle(item.1)
                                .font(.sfPro(size: 90, weight: .bold))
                        }
                    }
                    
                    HStack {
                        if let overall = appData.todayStatistics?.overallTotal, overall > 0 {
                            Text("+\(overall)")
                                .font(.sfPro(size: 12, weight: .medium))
                                .foregroundStyle(.appCyan)
                        }
                        
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
                    
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Power Level")
                        .font(.sfProDisplay(.medium, size: 26))
                        .foregroundStyle(.white)
                    
                    Text("Complete arcs and habits to increase your power level; the tougher the arc and the longer the streak, the more points you gain.")
                        .font(.sfProDisplay(.regular, size: 14))
                        .foregroundStyle(.white.opacity(0.5))
                        
                }.padding(.horizontal, 16)

                    
                Button(action: {
                    withAnimation {
                        statisticsViewModel.showInfoPopup = false
                    }
                }
                ) {
                    Text("Got It")
                        .font(.sfProDisplay(.medium, size: 18))
                        .foregroundStyle(Color.sheetBackgroundColor)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.white)
                        .cornerRadius(18)
                        .padding(.horizontal, 16)
                }
                
            }.padding(.vertical, 40).background(
                LinearGradient(
                stops: [
                    Gradient.Stop(color: Color.cellBackgroundColor, location: 0.00),
                    Gradient.Stop(color: Color(red: 0.07, green: 0.07, blue: 0.07), location: 1.00)
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
                )
                )
                .cornerRadius(16)
                .overlay(
                RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(.white.opacity(0.1), lineWidth: 1))
                .padding(.horizontal, 30)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.sheetBackgroundColor.opacity(0.75).ignoresSafeArea())

    }
}

