//
//  ArcRowList.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct ArcRowList: View {
    @EnvironmentObject var state: AppDataStore
    @EnvironmentObject var swipeManager: SwipeManager
    let arc: SubscribedArc
    let editArcAction: () -> Void
    
    var body: some View {
        let color = ColorToken.from(string: arc.wrappedThemeColor)
        //  let icon = ColorToken.imageName(from: arc.wrappedThemeColor)
        SwipeableRow(
            id: arc.wrappedId,
            actions: {
                Button(action: {
                    print("Edit tapped for \(arc.wrappedTitle)")
                    editArcAction()
                }) {
                    HStack {
                        Image("editIcon")
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30)
                            .padding(.leading,20)
                        Spacer()
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            },
            content: {
                ZStack {
                    Image("ARC1")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 2)
                        .frame(height: 80)
                        .clipped()
                    
                    // Overlay tint
                    Color.black.opacity(0.3)
                        .frame(height: 80)
                    
                    VStack(spacing: 5) {
                        HStack(spacing: 10) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text("Day \(arc.wrappedDurationDays)")
                                        .font(.sfProDisplay(.light, size: 14))
                                        .opacity(0.7)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                }
                                .background(Color.clear)
                                .overlay(
                                    Capsule()
                                        .stroke(ColorToken.from(string: arc.wrappedThemeColor), lineWidth: 1)
                                )
                                .frame(height: 20)
                                
                                
                                HStack {
                                    if let title = arc.arcTemplate?.title {
                                        Text(arcFormatted: title, arcColor: ColorToken.from(string: arc.wrappedThemeColor))
                                    } else {
                                        Text(arcFormatted: "Arc Title")
                                    }
                                }
                            }
                            .foregroundStyle(.white)
                            .padding(.leading,10)
                            
                            Spacer()
                            
                            CounterPill(
                                text: "\(arc.completedTasksToday)/\(arc.wrappedHabitsCount)",
                                tint: color,
                                completed: arc.completedTasksToday,
                                total: arc.wrappedHabitsCount
                            )
                            .padding(.trailing,10)
                        }
                    }
                    
                    //                        if state.layout == .grid {
                    //                            let newWidth = (UIScreen.main.bounds.width - 30)
                    //                            let newHeight = newWidth * (45.0 / 187.0)
                    //                            GridTileView(
                    //                                itemType: .arc,
                    //                                values: arc.dailyProgressOpacities,
                    //                                selectedColor: color
                    //                            )
                    //                            .frame(height: newHeight)
                    //                            .padding(.horizontal, 10)
                    //                            .padding(.bottom, 8)
                    //                        }
                }
                .frame(height: 80)
                .background(.black)
                .cornerRadius(swipeManager.openRowID == arc.id ? 0 : 18)
                .contentShape(Rectangle())
                
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state.layout)
        .clipped()
    }
}


