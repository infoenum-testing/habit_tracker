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
    
    @State private var showEditArc = false
    @State private var showConfirmation = false
    let arcID: String
   
    var arc: SubscribedArc {
        appData.subscribedArcs.first(where: { $0.wrappedId == arcID })!
    }
    
    private var progress: CGFloat {
        return CGFloat(arc.completedTasksToday) / CGFloat(arc.wrappedHabitsCount)
    }

    var body: some View {
        let color = ColorToken.from(string: arc.wrappedThemeColor)
        ZStack {
            VStack(spacing: 0) {
                DetailHeader(title: arc.wrappedTitle, day: arc.wrappedDurationDays, backButtonTapped: {
                    dismiss()
                }, editButtonTapped: {
                    showEditArc = true
                })
                ScrollView(showsIndicators: false) {
                    
                    ScrollView(.horizontal) {
                        HStack {
                            DayStripView(
                                arc: appData.subscribedArcs.first(where: { $0.wrappedId == arcID })!
                            )
                        }.padding(5)
                    }.scrollDisabled(true)

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
                            if let id = task.id {
                                ArcTaskRow(arcID: arc.wrappedId, task: task, isCompleted: arc.isHabitCompleted(id), tint: color)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
                //Spacer(minLength: 0)
                HStack {
                    ShareProgressButton(height: 50 ,imageName: "shareIcon", title: "Share Progress" ,buttonAction: {
                        // handle share action
                    })
                        
                    ShareProgressButton(height: 50 ,imageName: "widget", title: "Add Widget" ,buttonAction: {
                        // handle share action
                    })
                }.padding(.horizontal)
                   .padding(.top)
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [color.opacity(0.55),.black, .black], startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        
        .fullScreenCover(isPresented: $showEditArc) {
               EditArcSheet(isPresented: $showEditArc)
                .preferredColorScheme(.dark)
           }
//           .sheet(isPresented: $showConfirmation) {
//               EndArcConfirmationSheet(isPresented: $showConfirmation,
//                                       arcName: "Gut Health Arc")
//               .preferredColorScheme(.dark)
//           }
    }
}

//struct ArcDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockState = AppState(arcs: MockData.arcs, habits: MockData.habits)
//
//        return ArcDetailView(arcID: MockData.arcs[0].id)
//            .environmentObject(mockState)
//            .background(Color.black)
//    }
//}



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
            // handle tap
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
    let arc: SubscribedArc   // contains totaldays and dayNumber
    
    private var visibleDays: [Int?] {
        let total = arc.wrappedDurationDays
        let current = 1
        
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
                    // placeholder (transparent to keep spacing)
                    Color.clear
                        .frame(width: 70, height: 90)
                }
            }
        }
      //  .frame(maxWidth: .infinity, alignment: .center)
        
    }
}
