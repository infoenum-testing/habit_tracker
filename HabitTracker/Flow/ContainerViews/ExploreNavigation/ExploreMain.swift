//
//  ExploreMain.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI
struct ExploreMain: View {
    
    @EnvironmentObject var router: NavigationRouter
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Header
            headerView
                .padding(.horizontal, 28)
                .padding(.bottom, 24)
            
            // MARK: - Scroll Content
            ScrollView {
                VStack(spacing: 32) {
                    ExploreSection(
                        title: "Trending Arcs",
                        itemsCount: 4,
                        columns: columns, onViewAll: {
                            router.push(to: .allArcsView)
                        }
                    )
                    ExploreSection(
                        title: "Trending Habits",
                        itemsCount: 4,
                        columns: columns, onViewAll: {
                            router.push(to: .allHabitsView)
                        }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .padding(.top, 72)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(red: 0.1, green: 0.1, blue: 0.1))
        .ignoresSafeArea()
    }
}

// MARK: - Header
private extension ExploreMain {
    var headerView: some View {
        VStack(spacing: 20) {
            Text("Explore")
                .font(Font.inter(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .top)
            
            HStack {
                Image("magnifying-glass-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                
                Spacer()
                
                Image("Vector")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.1))
            .cornerRadius(17)
        }
    }
}

// MARK: - Section Component
struct ExploreSection: View {
    let title: String
    let itemsCount: Int
    let columns: [GridItem]
    let onViewAll: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text(title)
                    .font(Font.sfPro(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    onViewAll()
                } label: {
                    HStack(spacing: 2) {
                        Text("View All")
                            .font(Font.sfPro(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Image("chevron-right-small")
                            .frame(width: 28, height: 28)
                    }
                }
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<itemsCount, id: \.self) { _ in
                    if title == "Trending Arcs" {
                        ArcCardCell()
                            .aspectRatio(1, contentMode: .fit)
                    } else {
                        TrendingCardView()
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreMain()
}
