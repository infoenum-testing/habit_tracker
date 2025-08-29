//
//  HomeScreen.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var swipeManager = SwipeManager()
    @State private var showEditArc = false
    @State private var showHabitEditSheet = false


    var body: some View {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    HomeHeader()
                        .padding(.top, 6)
                        .padding(.horizontal,20)
                        DateStrip()
                            .padding(.top, 4)
                    Text("Todays Tasks")
                        .font(.sfProDisplay(.medium, size: 17))
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal,20)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            // Arc Cards
                            
                            
                            ForEach(appData.allSubscribedArcs) { arc in
                                ArcRowList(arc: arc) {
                                    withAnimation(.spring()) {
                                        appData.selectedArctoDelete = arc
                                        showEditArc = true
                                        swipeManager.closeAll()
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        swipeManager.closeAll()
                                    }
                                    router.push(to: Route.arcDetail(id: arc.wrappedId))
                                }
                            }
                            
                            ForEach(appData.allSubscribedHabits) { habit in
                                HabitRowList(habit: habit, editHabitAction: {
                                    withAnimation(.spring()) {
                                        appData.selectedHabitToDelete = habit
                                        showHabitEditSheet = true
                                        swipeManager.closeAll()
                                    }
                                })
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            swipeManager.closeAll()
                                        }
                                    }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 20)
                    }
                    .environmentObject(swipeManager)
                }
            }
            .toolbar(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .navigationBarHidden(true)
        
//            .fullScreenCover(isPresented: $showEditArc) {
//                   EditArcSheet(isPresented: $showEditArc)
//                    .preferredColorScheme(.dark)
//               }
        
            .fullScreenCover(isPresented: $showHabitEditSheet) {
                HabitEditSheet()
                    .preferredColorScheme(.dark)
               }
        
            .sheet(isPresented: $showEditArc) {
                EditArcSheet(isPresented: $showEditArc)
                    .presentationDetents([.height(400)])
                    .presentationCornerRadius(24)
                    .presentationBackground {
                        Color(UIColor.systemBackground)
                    }
                    .preferredColorScheme(.dark)
                    
            }
            .onAppear {
              let a =  CoreDataManager.shared.fetchAllArcsData()
                print("Fetched Arcs from CoreData: \(a.count)")
            }
           
    }
}

// MARK: - Preview
#Preview {
    HomeView()
        .environmentObject(
            AppState(arcs: MockData.arcs, habits: MockData.habits)
        )
        .preferredColorScheme(.dark)
}
