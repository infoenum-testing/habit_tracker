//
//  AllArcsView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 22/08/25.
//

import SwiftUI

struct AllArcsView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: String = "All"
    @State private var showAll: Bool = false

    let title : String
    private let categories = [
        StringConstants.ExploreNavigation.all,
        StringConstants.ExploreNavigation.health,
        StringConstants.ExploreNavigation.mentality,
        StringConstants.ExploreNavigation.lifestyle
    ]
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    private var filteredArcs: [ArcTemplate] {
        if selectedCategory == "All" {
            return appData.allArcs
        } else {
            return appData.allArcs.filter { arc in
                arc.categoriesArray.contains { $0.caseInsensitiveCompare(selectedCategory) == .orderedSame }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(alignment: .center, spacing: 20) {
                
                HStack(alignment: .center, spacing: 18) {
                    
                    RoundBackButton(backgroundColor: .white.opacity(0.35), action: {
                        dismiss()
                    })
                    
                    HStack(spacing: 5) {
                        Text(title)
                            .font(Font.inter(size: 20, weight: .medium))
                            .foregroundColor(Color.appPearlWhite)
                        
                        Image("arcIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.appPearlWhite)
                    }
                    
                    Spacer()
                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                DashedLine()
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.navBackground.ignoresSafeArea(edges: .top))
            
            HStack {
                Button {
                    showAll.toggle()
                } label: {
                    Text(showAll ? "Show Less" : "View All")
                        .font(.sfProDisplay(.medium, size: 14))
                        .foregroundColor(.white)
                }
                Spacer()
                
                    
            }
            .padding(.horizontal)
//            HStack(spacing: 8) {
//                ForEach(categories, id: \.self) { category in
//                    Button(action: {
//                        selectedCategory = category
//                    }) {
//                        Text(category)
//                        
//                            .font(Font.sfPro(size: 16, weight: .regular))
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 20)
//                        
//                            .background(
//                                selectedCategory == category ?
//                                Color.white.opacity(0.07) : Color.clear
//                            )
//                            .foregroundColor(selectedCategory == category ?
//                                             Color.white : Color.white.opacity(0.6))
//                            .cornerRadius(20)
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .center)
            
            if filteredArcs.isEmpty {
                VStack {
                    Spacer()
                    Text(StringConstants.ExploreNavigation.noArcsFound)
                        .font(Font.sfPro(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(filteredArcs.prefix(showAll ? filteredArcs.count : 6 ), id: \.id) { arc in
                            Button {
                                router.push(to: .arcDetailPreJoinView(arcTemplate: arc))
                            } label: {
                                NewArcsCell(arc: arc)
                            }
                            .padding(.vertical, 10)
                        }
                    .padding(.horizontal, 20)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.backgroundColor)
        .navigationBarBackButtonHidden()
    }
}
