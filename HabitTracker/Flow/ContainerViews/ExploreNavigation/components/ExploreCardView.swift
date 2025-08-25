//
//  ExploreCardView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct ExploreCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Title
            HStack(spacing: 6) {
                Text("Arcs")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                
                Image(systemName: "sparkles")
                    .foregroundColor(.white)
            }
            
            // Two crossed cards
            HStack(spacing: -40) {
                ArcItemView(
                    imageName: "arc1",
                    title: "White Smile Arc",
                    subtitle: "Make a Strong First Impression",
                    days: "30 Days",
                    habits: "4 Habits"
                )
                .rotationEffect(.degrees(-8))
                
                ArcItemView(
                    imageName: "arc2",
                    title: "75 Hard Arc",
                    subtitle: "Your Blueprint to Become Unstoppable",
                    days: "75 Days",
                    habits: "7 Habits"
                )
                .rotationEffect(.degrees(8))
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(width: 260, height: 180, alignment: .topLeading) // smaller height
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.21, green: 0.22, blue: 0.23),
                    Color(red: 0.58, green: 0.6, blue: 0.63).opacity(0.75)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(24)
        .clipped() // 👈 ensures inner cards get cut at the container boundary
    }
}

// MARK: - Inner Card
struct ArcItemView: View {
    var imageName: String
    var title: String
    var subtitle: String
    var days: String
    var habits: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("card")
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 200) // taller than container
                .clipped()
                .cornerRadius(16)
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.85)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 6) {
                // Top badges
                HStack(spacing: 6) {
                    Label(days, systemImage: "clock")
                    Label(habits, systemImage: "checkmark")
                }
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
                .padding(.top, 8)
                
                Spacer()
                
                // Title & subtitle
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(12)
        }
        .frame(width: 140, height: 200) // deliberately taller
        .shadow(radius: 6)
    }
}

#Preview {
    ExploreCardView()
        .preferredColorScheme(.dark)
}
