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
    @EnvironmentObject var state: AppState
    @EnvironmentObject var appData: AppDataStore
    @EnvironmentObject var navigation: NavigationRouter

    @State private var showEditArc = false
    @State private var showConfirmation = false
    let arcID: String
   
    private var arc: SubscribedArc? {
        appData.allSubscribedArcs.first(where: { $0.wrappedId == arcID })
    }
    
    private var progress: CGFloat {
        guard let arc else { return 0 }
        return arc.wrappedHabitsCount > 0
            ? CGFloat(arc.completedTasksToday) / CGFloat(arc.wrappedHabitsCount)
            : 0
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

                            CircularArcProgressView(progress: progress, tint: color)
                                .padding()
                            
                            VStack(alignment: .center, spacing: 6) {
                                Text(arc.wrappedTitle)
                                    .font(.sfProDisplay(.semibold, size: 35))
                                    .foregroundColor(.white)
                                Text("\(arc.wrappedDurationDays) Days Challenge")
                                    .font(.sfProDisplay(.medium, size: 16))
                                    .foregroundColor(.textGray)
                            }

                            VStack(spacing: 12) {
                                ForEach(arc.wrappedHabits) { task in
                                    if task.id != nil {
                                        ArcTaskRow(
                                            arc: arc,
                                            task: task,
                                            tint: color
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                        }
                        
                        HStack {
                            ShareProgressButton(height: 50 ,imageName: "shareIcon", title: "Share Progress") {
                                // handle share action
                            }
                            
                            ShareProgressButton(height: 50 ,imageName: "widget", title: "Add Widget") {
                                // handle share action
                            }
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
                    Text("This arc has been deleted.")
                        .foregroundColor(.red)
                        .padding()
                    Button("Close") { dismiss() }
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
    }
}




struct CircularArcProgressView: View {
    var progress: Double
    var tint: Color
    
    var body: some View {
        ZStack {
            // Base circle
            Circle()
                .stroke(Color(UIColor.appGray), lineWidth: 12)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 12, lineCap: .round))
              .rotationEffect(.degrees(-90))   // start at top
            
            // Center icon
            Image("star")
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(width: 135, height: 135)
    }
}



import SwiftUI

struct ShareProgressButton: View {
    var height: CGFloat = 60
    var imageName: String?
    var title: String
    var buttonAction: () -> Void
    var body: some View {
        Button(action: {
            buttonAction()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color(white: 0.85))
                    .frame(height: height)
                    .offset(y: 4)

                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.white)
                    .frame(height: height)
                HStack(spacing: 5) {
                    if let imageName = imageName {
                        Image(imageName)
                            .font(.system(size: 18, weight: .medium))
                    }
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                }
                .foregroundColor(.black)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ShareProgressButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ShareProgressButton(imageName: "shareIcon", title: "Share Progress" ,buttonAction: {
                // handle share action
            })
        }
    }
}



struct DayStripView: View {
    let arc: SubscribedArc
    
    private var visibleDays: [Int?] {
        let total = arc.wrappedDurationDays
        let current = arc.currentDayIndex
        
        // Always want 5 slots around the current day
        let start = current - 2
        let end = current + 2
        
        return (start...end).map { day in
            (day >= 1 && day <= total) ? day : nil
        }
    }
    
    var body: some View {
        HStack {
            ForEach(Array(visibleDays.enumerated()), id: \.offset) { _, day in
                if let day = day {
                    DayPill(
                        day: day,
                        isSelected: (day == arc.currentDayIndex),
                        isPast: day < arc.currentDayIndex
                    )
                } else {
                    Color.clear
                        .frame(width: 70, height: 90)
                }
            }
        }
    }
}
