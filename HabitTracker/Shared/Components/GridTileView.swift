//
//  HeatmapRow.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

struct GridTileView: View {
    let itemType: ItemType
    let values: [Double]
    let selectedColor: Color
    
    private let columnsCount = 20
    private let rowsCount = 5
    private let spacing: CGFloat = 4
    //private let gridHeight: CGFloat = 100
    
    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let totalHeight = geo.size.height
            let squareSize = (totalWidth - (CGFloat(columnsCount - 1) * spacing)) / CGFloat(columnsCount)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnsCount),
                spacing: spacing
            ) {
                ForEach(0..<(columnsCount * rowsCount), id: \.self) { index in
                    let row = index / columnsCount
                    let col = index % columnsCount
                    // ✅ Mirror horizontally → starts top-right
                    let mirroredIndex = row * columnsCount + (columnsCount - 1 - col)
                    
                    let opacity = mirroredIndex < values.count ? values[mirroredIndex] : 0.3
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(selectedColor.opacity(opacity))
                        .frame(width: squareSize, height: squareSize)
                }
            }
            .frame(height: totalHeight, alignment: .top)
            .frame(width: totalWidth, alignment: .center)
            .position(x: geo.size.width / 2, y: totalHeight / 2)
        }
        //.frame(height: gridHeight)
    }
}
