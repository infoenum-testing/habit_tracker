//
//  HomeHeader.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct HomeHeader: View {
    @ObservedObject var swipeManager: SwipeManager
    var body: some View {
        HStack(alignment:.center) {
//            Image("star")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 20, height: 20)
            Text("logo")
                .font(.sfProDisplay(.medium, size: 26))
                .foregroundStyle(.white)
            Spacer()
            VStack {
                HStack(spacing: 10) {
                    ZStack {
                        Image("circularIndicator")
                            .resizable()
                            .frame(width: 5, height: 5)
                            .blur(radius: 5)
                        Image("circularIndicator")
                            .resizable()
                            .frame(width: 5, height: 5)
                            .shadow(radius: 10)
                    }
                    
                    Text("\(1) Active Arcs")
                        .font(.sfProDisplay(.medium, size: 14))
                        .foregroundStyle(.white)
                }
                .padding()
            }.frame(height: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            
            
            VStack {
                HStack(spacing: 10) {
                    Image("arrow-up-double")
                        .resizable()
                        .frame(width: 15, height: 15)
                    
                    Text("\(231)")
                        .font(.sfProDisplay(.medium, size: 14))
                        .foregroundStyle(.white)
                }.padding()
                
            }.frame(height: 30)
                .background(Color.white.opacity(0.10))
                .cornerRadius(13)
                .overlay(
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
//            HStack(spacing: 10) {
//                LayoutToggle(swipeManager: swipeManager)
//            }
        }
    }
}
