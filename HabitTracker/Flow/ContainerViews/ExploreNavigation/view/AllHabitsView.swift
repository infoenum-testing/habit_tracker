//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Swift Copilot on 22/08/25.
//

import SwiftUI

struct AllHabitsView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    
    @State private var selectedCategory: String = "All"
    @State private var selectedHabit: HabitTemplate? = nil
    private let categories = ["All", "Health", "Mentality", "Lifestyle"]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var filteredHabits: [HabitTemplate] {
        if selectedCategory == "All" {
            return appData.allHabits
        } else {
            return appData.allHabits.filter { habit in
                habit.tagsArray.contains { $0.caseInsensitiveCompare(selectedCategory) == .orderedSame }
            }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(alignment: .center, spacing: 19.2) {
                HStack {
                    HStack(alignment: .center, spacing: 8.4) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image("arrow-left")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    .padding(10.8)
                    .background(.white.opacity(0.07))
                    .cornerRadius(55.2)
                    
                    Spacer()
                    
                    Text("Habits")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Spacer()
                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.navBackground.ignoresSafeArea(edges: .top))
            
            
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category)
                            .font(.system(size: 15, weight: .medium))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                selectedCategory == category ?
                                Color.white.opacity(0.15) : Color.clear
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
                    Text("No habits found")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(filteredHabits, id: \.id) { habit in
                            HabitCardCellView(habit: habit){
                                selectedHabit = habit
                            }
                            .aspectRatio(1, contentMode: .fit)
                            
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .sheet(item: $selectedHabit) { habit in
            HabitCustomizationSheet(habit: habit)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(45)
        }
    }
}

#Preview {
    AllHabitsView()
}
