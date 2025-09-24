//
//  NewExploreMain.swift
//  HabitTracker
//
//  Created by IE14 on 24/09/25.
//

import SwiftUI

struct NewExploreMain: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    @State private var isArkSelected: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                ExploreHeaderView(isArkSelected: $isArkSelected)
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color.navBackground)
            DashedLine()
            
            searchView
                .padding(.horizontal, 24)
                .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 15) {
                    if isArkSelected {
                        ForEach(appData.allArcs.prefix(4), id: \.id) { arc in
                            Button {
                                
                            } label: {
                                NewArcsCell(arc: arc)
                            }
                        }
                    } else {
                        ForEach(appData.allHabits.prefix(4), id: \.id) { habit in
                            
                            Button {
                            } label: {
                                NewHabitCardCell(habit: habit)
                            }
                        }
                    }
                }
            }.padding(.top, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.sheetBackgroundColor.ignoresSafeArea())
    }
}

extension NewExploreMain {
    private var searchView: some View {
        
        VStack(spacing: 25) {
            
            HStack {
                Image( StringConstants.Image.magnifyingGlass)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                
                Spacer()
                
                Image(StringConstants.Image.vector)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.searchBarColur)
            .cornerRadius(17)

            HStack {
                Text(StringConstants.ExploreNavigation.trendingArcs)
                    .font(.sfProDisplay(.medium, size: 14))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    router.push(to: .allArcsView)
                } label: {
                    Text(StringConstants.ExploreNavigation.viewAll)
                        .font(.sfProDisplay(.medium, size: 12))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
        }
    }
    

    
    
}

#Preview {
    NewExploreMain()
}
