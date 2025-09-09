//
//  LayoutToggle.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct LayoutToggle: View {
    @EnvironmentObject var state: AppDataStore
    @Namespace private var animation
    @ObservedObject var swipeManager: SwipeManager
    
    var body: some View {
        HStack() {
            HStack {
                toggleButton(icon: "menu", layout: .list)
                toggleButton(icon: "grid", layout: .grid)
            }
        }
        .frame(width: 110, height: 40)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.25), lineWidth: 1)
        )
    }
    
    private func toggleButton(icon: String, layout: HomeLayout) -> some View {
        Button {
            withAnimation(.spring()) {
                state.layout = layout
            }
            // Delay layout change so it feels smoother
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    swipeManager.closeAll()
                }
            }
        } label: {
            ZStack {
                if state.layout == layout {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white)
                        .matchedGeometryEffect(id: "selection", in: animation)
                        .frame(width: 45, height: 28)
                        .cornerRadius(14)
                }
                
                HStack {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(state.layout == layout ? .black : .white.opacity(0.25))
                }.frame(width: 45, height: 28)
                    .cornerRadius(14)
            }
        }
        .buttonStyle(.plain)
    }
}

