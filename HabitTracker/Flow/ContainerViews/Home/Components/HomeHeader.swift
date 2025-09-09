//
//  HomeHeader.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct HomeHeader: View {
    @ObservedObject var swipeManager: SwipeManager
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
                LayoutToggle(swipeManager: swipeManager)
            }
        }
    }
}
