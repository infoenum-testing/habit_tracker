//
//  ArcDetailsView.swift
//  HabitTracker
//
//  Created by ie15 on 25/08/25.
//

import SwiftUI

struct ArcDetailPreJoinView: View {
    @Environment(\.dismiss) private var dismiss
    let arc: ArcTemplate
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("arc_details")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .leading){
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {
                            RoundBackButton(backgroundColor: .black.opacity(0.65), action: {
                                dismiss()
                            })
                            Spacer()
                            RoundBackButton(icon: "shareIcon", backgroundColor: .black.opacity(0.65), action: {
                                dismiss()
                            })
                            
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 8){
                            HStack(alignment: .center) {
                                TextBadgeView(icon: "timeCircle")
                                    .background(Color.white)
                                    .cornerRadius(20)
                                TextBadgeView(icon: "arc")
                                    .background(Color.white)
                                    .cornerRadius(20)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Gut Health Arc")
                                .font(Font.sfPro(size: 38, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text("Your gut impacts more than digestion. It influences how you look, feel, and think every day. The Gut Health Arc guid ... more ")
                                .font(Font.sfPro(size: 14))
                                .foregroundStyle(Color.white.opacity(0.5))
                            
                            HStack(alignment: .center) {
                                TextBadgeViewForGutHealth(title: "Clear skin", foregroundColor: .white, icon: "check")
                                    .background(Color.white.opacity(0.14))
                                    .cornerRadius(20)
                                
                                TextBadgeViewForGutHealth(title: "More energy", foregroundColor: .white, icon: "check")
                                    .background(Color.white.opacity(0.14))
                                    .cornerRadius(20)
                                
                                TextBadgeViewForGutHealth(title: "Better mood", foregroundColor: .white, icon: "check")
                                    .background(Color.white.opacity(0.14))
                                    .cornerRadius(20)
                                
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal, 20)
                    
                    //            }
                    
                    DashedLine()
                        .padding(.top, 20)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Daily Habits")
                                .font(Font.sfPro(size: 17, weight: .medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 0)
                        .padding(.top, 12)
                        .padding(.bottom, 0)
                        
                        VStack(alignment: .leading, spacing: 13) {
                            let habits = Array((arc.habits as? Set<HabitTemplate>) ?? [])

                            ForEach(habits, id: \.id) { habit in
                                DailyHabitsCellView( habit: habit, color: .red)
                            }
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top)
                
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
                .navigationBarBackButtonHidden()
                
                ShareProgressButton(title: "Join arc",buttonAction: {
                    // handle share action
                })
                .padding(.horizontal, 20)
            }
            
        }
        .background(Color.backgroundColor)
    }
}

//#Preview {
//    ArcDetailPreJoinView()
//}

struct DashedLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 1) // line thickness
            .foregroundColor(.clear) // transparent fill
            .background(
                Color.clear
                    .overlay(
                      Rectangle()
                        .stroke(Color(red: 0.99, green: 0.99, blue: 0.99).opacity(0.16), style: StrokeStyle(lineWidth: 1.14, dash: [5]))
                    )
            )
    }
}
