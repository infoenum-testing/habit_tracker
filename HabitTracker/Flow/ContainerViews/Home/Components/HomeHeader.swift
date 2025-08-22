//
//  HomeHeader.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct HomeHeader: View {
    @EnvironmentObject var state: AppState
    var body: some View {
        HStack(alignment:.center) {
            Image("star")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text("arcetype")
                .font(.sfProDisplay(.medium, size: 26))
                .foregroundStyle(.white)
            Spacer()
            HStack(spacing: 10) {
                LayoutToggle()
//                CircleButton(icon: "bell", action: {
//                    //
//                }, width: 25, height: 25)
//                    .frame(width: 50, height: 50)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeHeader()
        .padding()
        .background(Color.black) // so white text is visible
        .environmentObject(
            AppState(arcs: MockData.arcs, habits: MockData.habits)
        )
        .preferredColorScheme(.dark)
}

