//
//  EmptyArcCardView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import SwiftUI

struct EmptyArcCardView: View {
    let width: CGFloat = UIScreen.main.bounds.width / 2.3
    let height: CGFloat = UIScreen.main.bounds.width / 2.3
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                Text("You haven't completed any Arcs yet.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("When you subscribe and complete an Arc it will show here.")
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.6))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .padding(.vertical)
                
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.cellBackgroundColor)
                .shadow(radius: 8)
        )
    }
}

#Preview {
    EmptyArcCardView()
}
