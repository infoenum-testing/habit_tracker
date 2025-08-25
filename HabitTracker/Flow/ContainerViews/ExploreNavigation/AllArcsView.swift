//
//  AllArcsView.swift
//  HabitTracker
//
//  Created by ie15 on 22/08/25.
//

import SwiftUI

struct AllArcsView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<10) { _ in
                    ArcCardCell()
                        .aspectRatio(1, contentMode: .fit) // 👈 keeps square
                }
            }
            .padding(.horizontal, 16) // matches grid spacing
            .padding(.top, 16)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    AllArcsView()
}
