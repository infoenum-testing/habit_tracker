//
//  ArcsView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation
import SwiftUI

struct ArcsView: View {
    
    @EnvironmentObject var appData: AppDataStore
    var isArc: Bool
    
    var body: some View {
        ZStack {
            // Background with corner radius + gradient
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color.darkGrayishColor, location: 0.00),
                            Gradient.Stop(color: Color.slateGrayColor.opacity(0.75), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1.04)
                    )
                )
                .shadow(radius: 8)
            
            VStack(spacing: 5) {
                // Title
                HStack {
                    Text(isArc ? StringConstants.ExploreNavigation.arcs : StringConstants.ExploreNavigation.habits)
                        .foregroundColor(.white)
                        .font(Font.sfPro(size: 23, weight: .medium))
                        .padding(.leading)
                    
                    if isArc {
                        Image(StringConstants.Image.arc)
                            .resizable()
                            .foregroundStyle(Color.appPearlWhite)
                            .frame(width: 20,height: 20)
                    }
                    
                    Spacer()
                }
                ZStack {
                    if isArc {
                        let arcs = Array(appData.allArcs.prefix(2).enumerated())
                        ForEach(arcs, id: \.offset) { index, element in
                            let arc = element
                            arcCardView(arc: arc, index: index)
                        }
                    } else {
                        let habits = Array(appData.allHabits.prefix(2).enumerated())
                        ForEach(habits, id: \.offset) { index, element in
                            let habit = element
                            habitCardView(habit: habit, index: index)
                        }
                    }
                }
            }
            .padding(.top)
        }.clipped()
    }
    
    private func arcCardView(arc: ArcTemplate, index: Int) -> some View {
        TopArcCardView(
            title: arc.title ?? "",
            subtitle: arc.descriptionText ?? "",
            days: "\(arc.durationDays)",
            habits: "\(arc.habitList.count)",
            imageName: StringConstants.Image.card,
            color: arc.colorToken ?? ""
        )
        .rotationEffect(.degrees(index == 0 ? -8 : 12))
        .offset(x: index == 0 ? -25 : 35, y: index == 0 ? 5 : -2)
    }
    
    private func habitCardView(habit: HabitTemplate, index: Int) -> some View {
        TopHabitCardView(habit: habit)
            .rotationEffect(.degrees(index == 0 ? -8 : 14))
            .offset(x: index == 0 ? -25 : 37, y: index == 0 ? 4 : 6)
        
    }
}
