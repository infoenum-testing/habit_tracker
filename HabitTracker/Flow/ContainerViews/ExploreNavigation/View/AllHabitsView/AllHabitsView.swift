//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 22/08/25.
//

import SwiftUI

struct AllHabitsView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    
    @State private var selectedCategory: String = "All"
    @State private var selectedHabit: HabitTemplate? = nil
    private let categories = [
        StringConstants.ExploreNavigation.all,
        StringConstants.ExploreNavigation.health,
        StringConstants.ExploreNavigation.mentality,
        StringConstants.ExploreNavigation.lifestyle
    ]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var filteredHabits: [HabitTemplate] {
        if selectedCategory == "All" {
            return appData.allHabits
        } else {
            return appData.allHabits.filter { habit in
                habit.categoresArray.contains { $0.caseInsensitiveCompare(selectedCategory) == .orderedSame }
            }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .center, spacing: 19) {
                HStack(alignment: .center, spacing: 18) {
                    RoundBackButton(){
                        dismiss()
                    }
                    HStack(spacing: 4) {
                        Text(StringConstants.ExploreNavigation.habits)
                            .font(Font.sfPro(size: 29, weight: .medium))
                            .foregroundColor(Color.appPearlWhite)
                    }
                    
                    Spacer()
                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                DashedLine()
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.navBackground.ignoresSafeArea(edges: .top))
            
            
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category)
                            .font(Font.sfPro(size: 16, weight: .regular))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                selectedCategory == category ?
                                Color.white.opacity(0.07) : Color.clear
                            )
                            .foregroundColor(selectedCategory == category ?
                                             Color.white : Color.white.opacity(0.6))
                            .cornerRadius(20)
                    }
                }
            }
            
            if filteredHabits.isEmpty {
                VStack {
                    Spacer()
                    Text(StringConstants.ExploreNavigation.noHabitsFound)
                        .font(Font.sfPro(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(filteredHabits, id: \.wrappedId) { habit in
                            Button {
                                selectedHabit = habit
                            } label: {
                                HabitCardCellView(habit: habit)
                                    .aspectRatio(1, contentMode: .fit)
                            } 
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.backgroundColor.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .sheet(item: $selectedHabit) { habit in
            HabitCustomizationSheet(habit: habit)
                .presentationDetents([.large])
                .presentationCornerRadius(45)
        }
    }
}

#Preview {
    AllHabitsView()
}
