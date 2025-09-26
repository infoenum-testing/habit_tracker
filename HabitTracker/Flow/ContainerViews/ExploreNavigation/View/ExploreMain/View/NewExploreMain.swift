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
    @State private var showAddHabitSheet: Bool = false
    @State var selectedHabit: HabitTemplate? = nil
    @State private var showAllHabits: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                VStack(alignment: .leading) {
                    ExploreHeaderView(isArkSelected: $isArkSelected)
                }
                
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color.navBackground)
                .padding(.horizontal, -24)
                DashedLine()
                    .padding(.horizontal, -24)
                
                searchView
                    .padding(.top, 20)
                
                if !isArkSelected {
                    HStack {
                        Text("Trending Habits")
                            .font(.sfProDisplay(.medium, size: 14))
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            showAllHabits.toggle()
                        } label: {
                            Text(showAllHabits ? "Show Less" : "View All")
                                .font(.sfProDisplay(.medium, size: 14))
                                .foregroundColor(.white.opacity(0.5))

                        }

                    }
                    .padding(.top,20)
                    
                    
                }
               
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        if isArkSelected {
                            ForEach(appData.allArcs.prefix(4), id: \.id) { arc in
                                    NewArcsCell(arc: arc)
                                        .onTapGesture {
                                            router.push(to: .arcDetailPreJoinView(arcTemplate: arc))
                                        }
                            }
                            
                            CategoriesView { title, count, image in
                                print("Category tapped: \(title)")
                                router.push(to: .allArcsView(title: title))
                            }
                            .padding(.top)
                            .padding(.bottom)
                            
                        } else {
                            ForEach(appData.allHabits.prefix(showAllHabits ? appData.allHabits.count : 6), id: \.id) { habit in
                                    NewHabitCardCell(habit: habit, addAction: {
                                        showAddHabitSheet = true
                                    }, selectedHabit: $selectedHabit)
                            }
                        }
                    }
                    
                   
                    
                }.padding(.top, 15)
            }.padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.sheetBackgroundColor.ignoresSafeArea())
        .sheet(item: $selectedHabit) { habit in
            AddHabitSheet(habit: habit)
                .presentationDetents([.height(400)])
                .presentationCornerRadius(24)
                .presentationBackground {
                    Color(UIColor.systemBackground)
                }
        }
        .onAppear {
            showAllHabits = false
        }
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
                
                TextField("Search arc...", text: .constant(""))
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                
                Image(StringConstants.Image.vector)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.searchBarColur)
            .cornerRadius(17)
        }
    }
}

#Preview {
    NewExploreMain()
}



