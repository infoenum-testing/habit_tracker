//
//  AllArcsView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct AllArcsView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: String = "All"
    private let categories = ["All", "Health", "Mentality", "Lifestyle"]
    
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var filteredArcs: [ArcTemplate] {
        if selectedCategory == "All" {
            return appData.allArcs
        } else {
            return appData.allArcs.filter { arc in
                arc.tagsArray.contains { $0.caseInsensitiveCompare(selectedCategory) == .orderedSame }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(alignment: .center, spacing: 20) {
                
                HStack(alignment: .center, spacing: 18) {
                    RoundBackButton(){
                        dismiss()
                    }
                    HStack(spacing: 4) {
                        Text("Arcs")
                            .font(Font.sfPro(size: 29, weight: .medium))
                            .foregroundColor(Color.appWhite)
                        
                        Image("arc")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.appWhite)
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
            
            
            
            HStack(spacing: 8) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category)
                            
                            .font(.system(size: 15, weight: .medium))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            
                            .background(
                                selectedCategory == category ?
                                Color.white.opacity(0.15) : Color.clear
                            )
                            .foregroundColor(selectedCategory == category ?
                                             Color.white : Color.white.opacity(0.6))
                            .cornerRadius(20)
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            if filteredArcs.isEmpty {
                VStack {
                    Spacer()
                    Text("No arcs found")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredArcs, id: \.id) { arc in
                            
                            Button {
                                router.push(to: .arcDetailPreJoinView(arcTemplate: arc))
                            } label: {
                                ArcCardCell(arc: arc)
                                    .aspectRatio(1, contentMode: .fit)
                            }

                            
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black)
        .navigationBarBackButtonHidden()
        
    }
}

//#Preview {
//    AllArcsView()
//}
