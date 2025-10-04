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
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appData: AppDataStore

    var body: some View {
        HStack(alignment:.center) {
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
                    
                    Text("\(appData.allSubscribedArcs.count) Active Arcs")
                        .font(.sfProDisplay(.medium, size: 14))
                        .foregroundStyle(.white)
                }
                .padding()
            }.frame(height: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            
            Button {
                router.tab = 2
            } label: {
                VStack {
                    HStack(spacing: 10) {
                        Image("arrow-up-double")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text("\(appData.grandTotals.overall)")
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
            }

                
            
        }
    }
}
