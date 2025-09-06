//
//  HomeScreen.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var swipeManager = SwipeManager()
    @State private var showEditArc = false
    @State private var showHabitEditSheet = false
    @State private var showToast: Bool = false
    
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
                
                if appData.allSubscribedArcs.isEmpty && appData.allSubscribedHabits.isEmpty {
                    VStack {
                        Spacer()
                        Text("No tasks for today \n Add some habits or arcs to get started!")
                            .font(.sfProDisplay(.medium, size: 16))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
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
        }
        .toolbar(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .navigationBarHidden(true)
        .sheet(isPresented: $showHabitEditSheet) {
            HabitEditSheet()
                .preferredColorScheme(.dark)
                .presentationDetents([.fraction(0.95)])
                .presentationCornerRadius(24)
                .presentationDragIndicator(.hidden)
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
            for arc in appData.allSubscribedArcs {
                if let graceEndDate = arc.graceEndDate,
                   graceEndDate < Date() {
                    let _ = appData.saveHistory(for: arc, status: .expired)
                    appData.deleteArc(arc)
                }
            }
        }
    }
}
