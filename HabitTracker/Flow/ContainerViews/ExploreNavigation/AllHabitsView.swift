//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Swift Copilot on 22/08/25.
//

import SwiftUI

struct AllHabitsView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: String = "All"
    @State private var isSheetPresented: Bool = false
    private let categories = ["All", "Health", "Mentality", "Lifestyle"]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(alignment: .center, spacing: 19.2) {
                HStack {
                    HStack(alignment: .center, spacing: 8.4) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image("arrow-left")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    .padding(10.8)
                    .background(.white.opacity(0.07))
                    .cornerRadius(55.2)
                    
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
            
            
            HStack {
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
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(0..<10) { _ in
                        TrendingCardView()
                            .onTapGesture {
//                                router.push(to: .habitCutomizeSheetView)
                                isSheetPresented.toggle()
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isSheetPresented) {
            HabitCustomizationSheet()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(45)
        }
    }
}

#Preview {
    AllHabitsView()
}
