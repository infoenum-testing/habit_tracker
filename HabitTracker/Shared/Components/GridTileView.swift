//
//  HeatmapRow.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct GridTileView: View {
    var itemType: ItemType
    var values: [Int] = []
    var filledCount: Int
    var totalCols: Int = 20
    var totalRows: Int = 5
    
    var selectedColor: Color
    var baseOpacity: Double = 0.25
    
    @State private var unselectedColor: Color = .white.opacity(0.25)

    var body: some View {
        GeometryReader { geo in
            let cellW = (geo.size.width - CGFloat(totalCols - 1) * 4) / CGFloat(totalCols)
            let cellH = (geo.size.height - CGFloat(totalRows - 1) * 4) / CGFloat(totalRows)
            let size = min(cellW, cellH)
            
            VStack(alignment: .leading, spacing: 4) {
                ForEach(0..<totalRows, id: \.self) { r in
                    HStack(spacing: 4) {
                        ForEach(0..<totalCols, id: \.self) { c in
                            let idx = r * totalCols + (totalCols - 1 - c)
                            
                            if itemType == .arc {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(idx < values.count
                                          ? selectedColor.opacity(opacity(for: values[idx]))
                                          : unselectedColor)
                                    .frame(width: size, height: size)
                            } else {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(idx < filledCount ? selectedColor : unselectedColor)
                                    .frame(width: size, height: size)
                            }
                        }
                    }
                }
            }
        }
        .aspectRatio(CGFloat(totalCols) / CGFloat(totalRows), contentMode: .fit)
        .onAppear {
            unselectedColor = selectedColor.opacity(baseOpacity)
        }
    }
    
    /// Maps [threshold .. 100] → [baseOpacity .. 1]
    private func opacity(for value: Int) -> Double {
        let threshold = baseOpacity * 100  // e.g. 0.2 → 20, 0.3 → 30
        let clamped = max(threshold, min(100, Double(value)))
        let progress = (clamped - threshold) / (100 - threshold) // normalize
        return baseOpacity + progress * (1 - baseOpacity)
    }
}



struct HeatmapRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            GridTileView(itemType: .arc, values: (0..<1).map { _ in Int.random(in: 0...100) }, filledCount: 1, selectedColor: .appYellow)
                .frame(height: 20)
            GridTileView(itemType: .arc, values: (0..<5).map { _ in Int.random(in: 0...100) }, filledCount: 5, selectedColor: .appBlue)
                .frame(height: 20)
            GridTileView(itemType: .arc, values: (0..<14).map { _ in Int.random(in: 0...100) }, filledCount: 14, selectedColor: .appPurple)
                .frame(height: 20)
        }
        .padding()
        .background(Color.black)
    }
}
