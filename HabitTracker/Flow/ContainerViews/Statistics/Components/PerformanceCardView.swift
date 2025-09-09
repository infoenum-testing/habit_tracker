//
//  PerformanceCardView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 21/08/25.
//

import Foundation
import SwiftUI

struct PerformanceCardView: View {
    let iconName: String
    let title: String
    let score: Int
    let delta: Int
    let width : CGFloat = UIScreen.main.bounds.width / 2 - 30
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack() {
                VStack {
                    Image(iconName)
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
                    Text(title)
                        .font(.sfProDisplay(.medium, size: 16))
                        .foregroundStyle(.white)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack() {
                VStack(alignment: .leading) {
                    Text(StringConstants.Account.score)
                        .font(.sfProDisplay(.regular, size: 12))
                    Text("\(score)")
                        .font(.sfProDisplay(.bold, size: 48))
                }
                if delta > 0 {
                    HStack(spacing: 4) {
                        Text("+\(delta)")
                            .font(.sfProDisplay(.medium, size: 14))
                            .foregroundStyle(.brightGreen)
                        Image(StringConstants.Image.arrowUpCircle)
                            .resizable()
                            .frame(width: 12, height: 12)
                            .font(.caption2)
                    }
                    .frame(width: 56, height: 25)
                    .background(Color.capsuleGreen)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .frame(width: width, height: 150)
        .background(Color(UIColor.statsBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appGray, lineWidth: 2)
        )
        .padding(2)
    }
}


struct PerformanceCardView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceCardView(iconName: "discipline", title: "Discipline", score: 73, delta: 6)
            .preferredColorScheme(.dark)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
