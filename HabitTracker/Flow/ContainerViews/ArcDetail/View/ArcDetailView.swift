//
//  ArcDetailView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct ArcDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var navigation: NavigationRouter
    @State private var showAlert = false
    @State private var showEditArc = false
    @State private var showConfirmation = false
    let arcID: String
    
    private var arc: SubscribedArc? {
        appData.allSubscribedArcs.first(where: { $0.wrappedId == arcID })
    }
    
    var body: some View {
        Group {
            if let arc = arc {
                let color = ColorToken.from(string: arc.wrappedThemeColor)
                
                ZStack {
                    VStack(spacing: 0) {
                        DetailHeader(
                            title: arc.wrappedTitle,
                            day: arc.wrappedDurationDays,
                            backButtonTapped: { dismiss() },
                            editButtonTapped: {
                                showEditArc = true
                                appData.selectedArctoDelete = arc
                            }
                        )
                        
                        ScrollView(showsIndicators: false) {
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    DayStripView(arc: arc)
                                }
                                .padding(5)
                            }
                            .scrollDisabled(true)
                            
                            CircularArcProgressView(progress: arc.progress, tint: color)
                                .padding()
                            
                            VStack(alignment: .center, spacing: 6) {
                                Text(arc.wrappedTitle)
                                    .font(.sfProDisplay(.semibold, size: 35))
                                    .foregroundColor(.white)
                                Text("\(arc.wrappedDurationDays) \(StringConstants.ArcDetail.challengeText)")
                                    .font(.sfProDisplay(.medium, size: 16))
                                    .foregroundColor(.textGray)
                            }
                            
                            VStack(spacing: 12) {
                                ForEach(arc.wrappedHabitList) { task in
                                    ArcTaskRow(arc: arc, task: task, tint: color)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                        }
                        
                        HStack {
                            ShareProgressButton(height: 50 ,imageName: StringConstants.ArcDetail.shareIcon, title: StringConstants.ArcDetail.shareProgress,  buttonAction:  {
                                // handle share action
                            }, shouldShowArrow: false)
                            
                            ShareProgressButton(height: 50 ,imageName: StringConstants.ArcDetail.widgetIcon, title: StringConstants.ArcDetail.addWidget, buttonAction: {
                                // handle share action
                            }, shouldShowArrow: false)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        colors: [color.opacity(0.55), .black, .black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .navigationBarBackButtonHidden()
                .toolbar(.hidden)
                .sheet(isPresented: $showEditArc) {
                    EditArcSheet(isPresented: $showEditArc)
                        .presentationDetents([.height(400)])
                        .presentationCornerRadius(24)
                        .presentationBackground {
                            Color(UIColor.systemBackground)
                        }
                        .preferredColorScheme(.dark)
                }
                
            } else {
                // Fallback when arc no longer exists
                VStack {
                    Text(StringConstants.ArcDetail.arcDeleted)
                        .foregroundColor(.red)
                        .padding()
                    Button(StringConstants.ArcDetail.close) { dismiss() }
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
            }
        }
        .onChange(of: appData.allSubscribedArcs) { _ in
            // auto-dismiss if arc no longer exists
            if appData.allSubscribedArcs.first(where: { $0.wrappedId == arcID }) == nil {
                dismiss()
            }
        }
        .onChange(of: navigation.dismissAllSheets) { _ in
            dismiss()
        }
        
        .onAppear {
            if let arc = arc {
                checkArcStatus(for: arc)
            }
        }
        .alert(StringConstants.ArcDetail.reminderTitle, isPresented: $showAlert) {
            Button(StringConstants.ArcDetail.ok, role: .cancel) { }
        } message: {
            Text(StringConstants.ArcDetail.reminderMessage)
        }
        
    }
    
    private func checkArcStatus(for arc: SubscribedArc) {
        let today = Calendar.current.startOfDay(for: Date())
        let endDate = arc.wrappedEndDate
        let graceDate = arc.wrappedGraceEndDate
        
        if Calendar.current.isDate(graceDate, inSameDayAs: today),
           endDate < today,
           !appData.shownAlerts.contains(arc.wrappedId) {
            
            showAlert = true
            appData.shownAlerts.insert(arc.wrappedId) 
        }
    }

}
