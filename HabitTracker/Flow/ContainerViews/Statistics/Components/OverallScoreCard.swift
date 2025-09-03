//
//  OverallScoreCard.swift
//  HabitTracker
//
//  Created by IE14 on 21/08/25.
//

import Foundation
import SwiftUI

struct OverallScoreCard: View {
    @EnvironmentObject var appData: AppDataStore
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack() {
                        VStack {
                            Image("star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                                .padding()
                        }
                            .frame(width: 32, height: 32)
                            .background(.appGray)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text("[archetype]")
                                .font(.sfProDisplay(.medium, size: 10))
                                .foregroundColor(.gray)
                            Text("Overall Score")
                                .font(.sfProDisplay(.medium, size: 16))
                                .foregroundStyle(.white)
                        }
                    }

                  

                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        VStack(alignment: .leading) {
                            Text("\(appData.grandTotals.overall)")
                                .font(.sfProDisplay(.bold, size: 48))
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.white)
                            Text("Updated Daily")
                                .font(.sfProDisplay(.regular, size: 13))
                                .foregroundColor(.gray)
                        }

                        HStack(spacing: 4) {
                            Text("+\(appData.grandTotals.overall)")
                                .font(.sfProDisplay(.medium, size: 14))
                                .foregroundStyle(.brightGreen)
                            Image("arrowUpCircle")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .font(.caption2)
                        }
                        .frame(width: 56, height: 25)
                        .background(Color.capsuleGreen)
                        .cornerRadius(12)
                    }
                }
                Spacer()
                ZStack {
                    HStack {
                        Spacer()
                        Image("whiteCircleFilled")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .offset(x: 5, y: 5)
                    }
                    .frame(height: 130)
                    //.offset(x: 15, y: 15)
                   // .background(.red)
                    Image("graph")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130)
                        .offset(x: 15, y: 15)
                }.frame(height: 130)
            }
            .padding()

            HStack {
                Text("Today")
                    .font(.sfProDisplay(.medium, size: 14))
                    .foregroundStyle(.brightGreen)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
            }
           
                .background(Color.green.opacity(0.25))
                .cornerRadius(12)
                .padding(.top, 20)
                .padding(.trailing, 20)
        }
        .background(Color.statsBackground)
        .frame(height: 160)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.appGray, lineWidth: 1)
        )
       
    }
}

struct OverallScoreCard_Previews: PreviewProvider {
    static var previews: some View {
        OverallScoreCard()
            .padding()
            .background(Color.black.ignoresSafeArea())
    }
}
     
    
