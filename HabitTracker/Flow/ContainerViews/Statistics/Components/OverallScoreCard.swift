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
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack() {
                        VStack {
                            Image(StringConstants.Image.star)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                                .padding()
                        }
                        .frame(width: 32, height: 32)
                        .background(.appGray)
                        .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(StringConstants.Account.arcetype)
                                .font(.sfProDisplay(.medium, size: 10))
                                .foregroundColor(.gray)
                            Text(StringConstants.Account.overAllScore)
                                .font(.sfProDisplay(.medium, size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("\(appData.grandTotals.overall)")
                                .font(.sfProDisplay(.bold, size: 48))
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.white)
                            
                            if let overall = appData.todayStatistics?.overallTotal, overall > 0 {
                                HStack(spacing: 4) {
                                    Text("+\(overall)")
                                        .font(.sfProDisplay(.medium, size: 14))
                                        .foregroundStyle(.brightGreen)
                                    Image(StringConstants.Image.arrowUpCircle)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }
                                .frame(width: 56, height: 25)
                                .background(Color.capsuleGreen)
                                .cornerRadius(12)
                                .padding(.top, 9)
                            }
                        }
                        Text(StringConstants.Account.updatedDaily)
                            .font(.sfProDisplay(.regular, size: 13))
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                ZStack {
                    HStack {
                        Spacer()
                        Image(StringConstants.Image.whiteCircleFilled)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .offset(x: 15, y: 23)
                        Spacer()
                    }
                    .frame(height: 130)
                    Image(StringConstants.Image.graph)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130)
                        .offset(x: 15, y: 15)
                        
                }.frame(width: UIScreen.main.bounds.width / 2 - 20 ,  height: 130)
            }
            .padding()

            HStack {
                Text(StringConstants.Account.today)
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
     
    
