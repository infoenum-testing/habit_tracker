//
//  ExploreSection.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation
import SwiftUI


struct ExploreSection: View {
    let title: String
    let columns: [GridItem]
    let onViewAll: () -> Void
    var isHabitSection: Bool
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var router: NavigationRouter
    @Binding var selectedHabit: HabitTemplate?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text(title)
                    .font(Font.sfPro(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    onViewAll()
                } label: {
                    HStack(spacing: 2) {
                        Text(StringConstants.ExploreNavigation.viewAll)
                            .font(Font.sfPro(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Image(StringConstants.Image.chevronRightSmall)
                            .frame(width: 28, height: 28)
                    }
                }
            }
            
            LazyVGrid(columns: columns, spacing: 15) {
                
                if isHabitSection {
                    ForEach(appData.allHabits.prefix(4), id: \.id) { habit in
                        
                        Button {
                            selectedHabit = habit
                        } label: {
                            HabitCardCellView(habit: habit)
                                .aspectRatio(1, contentMode: .fit)
                        }
                        
                    }
                } else {
                    ForEach(appData.allArcs.prefix(4), id: \.id) { arc in
                        Button {
                            router.push(to: .arcDetailPreJoinView(arcTemplate: arc))
                        } label: {
                            ArcCardCell(arc: arc)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
            
        }
    }
}
