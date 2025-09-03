//
//  ArcDetailsView.swift
//  HabitTracker
//
//  Created by ie15 on 25/08/25.
//

import SwiftUI

struct ArcDetailPreJoinView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appdata: AppDataStore
    @State private var isExpanded: Bool = false
    @State private var truncated: Bool = false
    @State private var expanded: Bool = false
    let arc: ArcTemplate
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "less" : "more"
        }
    }
    
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
                        .padding(.horizontal, 20)
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8){
                                HStack(alignment: .center) {
                                    TextBadgeView(title: "\(arc.durationDays) Days" , icon: "timeCircle")
                                        .background(Color.white)
                                        .cornerRadius(20)
                                    TextBadgeView(title: "\(arc.habitsData?.count ?? 0) Habits" ,icon: "arc")
                                        .background(Color.white)
                                        .cornerRadius(20)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(arc.title ?? "")
                                    .font(Font.sfPro(size: 38, weight: .semibold))
                                    .foregroundStyle(Color.white)
                                
                                
                                VStack(alignment: .leading) {
                                    if let descriptionText = arc.descriptionText {
                                        ExpandableText(descriptionText, lineLimit: 2)
                                       
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                HStack(alignment: .center) {
                                    if let benefits = arc.benefits {
                                        FlowLayout(tags: benefits)
                                    }
                                }
                                
                            }
                            .padding(.top)
                        
                        .padding(.horizontal, 20)
                        
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
                                    ForEach(arc.habitList) { habit in
                                        ArcDailyHabitsCellView( habit: habit, color: ColorToken.from(string: arc.colorToken ?? "blue"))
                                    }
                                }
                                
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
                    .navigationBarBackButtonHidden()
                }
                
                ShareProgressButton(title: "Join arc",buttonAction: {
                    appdata.subscribe(to: arc) { result in
                        switch result {
                        case .success(let subscribedArc):
                            print("🎉 Subscribed and got arc: \(subscribedArc)")
                           dismiss()
                        case .failure(let error):
                            print("⚠️ Subscription failed: \(error)")
                        }
                    }
                })
                .padding(.horizontal, 20)
            }
            
        }
        .background(Color.backgroundColor)
        .toast(isShown: $appdata.showToast, title: "", message: appdata.toastMessage, type: appdata.toastType, alignment: .bottom)
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
                            .stroke(Color.white.opacity(0.09), style: StrokeStyle(lineWidth: 1.14, dash: [5]))
                    )
            )
    }
}



