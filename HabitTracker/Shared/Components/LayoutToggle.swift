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
    
    var body: some View {
        HStack(spacing: 5) {
            toggleButton(icon: "menu", isSelected: state.layout == .list) {
                state.layout = .list
            }
            
            toggleButton(icon: "grid", isSelected: state.layout == .grid) {
                state.layout = .grid
                    
            }
        }
        .frame(width: 100, height: 40)
        .background(.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 1)
        )
    }
    
    private func toggleButton(icon: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack{
                Image(icon)
                    .foregroundColor(isSelected ? .black : .white)
                    .frame(width: 15, height: 15)
            }.frame(width: 40, height: 28)
                .background(isSelected ? Color.white : Color.clear)
                .cornerRadius(14)
                
                
        }
        .buttonStyle(.plain)
    }
}


// MARK: - Preview
//#Preview {
//    LayoutToggle()
//        .padding()
//        .background(Color.black)
//        .environmentObject(
//            AppState(arcs: MockData.arcs, habits: MockData.habits)
//        )
//        .preferredColorScheme(.dark)
//}


//.background(
//    RoundedRectangle(cornerRadius: 10, style: .continuous)
//        .fill(isSelected ? Color.white : Color.clear)
//)
