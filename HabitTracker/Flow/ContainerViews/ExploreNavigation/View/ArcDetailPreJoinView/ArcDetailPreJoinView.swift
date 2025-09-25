//
//  ArcDetailsView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 25/08/25.
//

import SwiftUI

struct ArcDetailPreJoinView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appdata: AppDataStore
    @State private var isExpanded: Bool = false
    @State private var truncated: Bool = false
    @State private var expanded: Bool = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    let arc: ArcTemplate
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? StringConstants.ExploreNavigation.less : StringConstants.ExploreNavigation.more
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(StringConstants.Image.card)
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height * 0.35)
                .clipped()
                .overlay(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.08, green: 0.08, blue: 0.09).opacity(0.5), location: 0.00),
                                  Gradient.Stop(color: Color(red: 0.08, green: 0.08, blue: 0.09), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                          endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .blur(radius: 2.5)
            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .leading){
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {
                            RoundBackButton(backgroundColor: .white.opacity(0.35), action: {
                                dismiss()
                            })
                            Spacer()
                            RoundBackButton(icon: StringConstants.Image.shareIcon, backgroundColor: .white.opacity(0.35), action: {
                                dismiss()
                            })
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 70)
                        
                        ScrollView(showsIndicators: false) {
                            VStack {
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    
                                    if let title = arc.title {
                                        Text(arcFormatted: title, fontSize: 38)
                                            .foregroundStyle(Color.white)
                                    } else {
                                        Text(arcFormatted: "Arc Title")
                                            .foregroundStyle(Color.white)
                                    }
                                    
                                    
                                    HStack(alignment: .center) {
                                        TextBadgeView(
                                            title: "\(arc.durationDays) \(StringConstants.ExploreNavigation.days)",
                                            icon: StringConstants.Image.timeCircle
                                        )
                                        .background(.ultraThinMaterial.opacity(0.5))
                                        .cornerRadius(20)
                                        TextBadgeView(
                                            title: "Created by Arcetype Staff",
                                            icon: StringConstants.Image.arc
                                        )
                                        .background(.ultraThinMaterial.opacity(0.5))
                                        .cornerRadius(20)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                   
                                    
                                    
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
                                        Text(StringConstants.ExploreNavigation.dailyHabits)
                                            .font(Font.sfPro(size: 17, weight: .medium))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 0)
                                    .padding(.top, 12)
                                    .padding(.bottom, 0)
                                    
                                    VStack(alignment: .leading, spacing: 13) {
                                        ForEach(arc.habitList) { habit in
                                            ArcDailyHabitsCellView( habit: habit, color: .white)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.bottom, 110)
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
                }
                
                ShareProgressButton(title: StringConstants.ExploreNavigation.joinArc, buttonAction: {
                    appdata.subscribe(to: arc) { result in
                        switch result {
                        case .success(_):
                            alertMessage = StringConstants.Aleart.youHaveSuccesfully
                            isShowAlert = true
                            
                        case .failure(let error):
                            print("⚠️ Subscription failed: \(error)")
                        }
                    }
                })
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .toast(isShown: $appdata.showToast, title: "", message: appdata.toastMessage, type: appdata.toastType, alignment: .bottom)
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text(""),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    dismiss()
                })
            )
        }
    }
}




