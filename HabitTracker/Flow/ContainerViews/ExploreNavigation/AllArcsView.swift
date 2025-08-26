//
//  AllArcsView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct AllArcsView: View {
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: String = "All"
    private let categories = ["All", "Health", "Mentality", "Lifestyle"]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    RoundBackButton(){
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Habits")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Spacer()
                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
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
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<10) { _ in
                        ArcCardCell()
                            .aspectRatio(1, contentMode: .fit)
                            .onTapGesture {
                                router.push(to: .arcDetailPreJoinView)
                            }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black)
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    AllArcsView()
}
