//
//  HeatmapRow.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation

//struct GridTileView: View {
//    let itemType: ItemType
//    let values: [Double] // Opacity values for 40 days
//    var totalCols: Int = 20
//    var totalRows: Int = 5
//    
//    var selectedColor: Color
//    var baseOpacity: Double = 0.25
//    
//    @State private var unselectedColor: Color = .white.opacity(0.25)
//
//    var body: some View {
//        GeometryReader { geo in
//            let cellW = (geo.size.width - CGFloat(totalCols - 1) * 4) / CGFloat(totalCols)
//            let cellH = (geo.size.height - CGFloat(totalRows - 1) * 4) / CGFloat(totalRows)
//            let size = min(cellW, cellH)
//           
//            VStack(alignment: .leading, spacing: 4) {
////                ForEach(0..<totalRows, id: \.self) { r in
////                    let opacity = index < r.count ? values[index] : 0.0
////                    HStack(spacing: 4) {
////                        ForEach(0..<totalCols, id: \.self) { c in
////                            
////                            let idx = r * totalCols + (totalCols - 1 - c)
////                            
////                            //if itemType == .arc {
////                                RoundedRectangle(cornerRadius: 3)
////                                .fill(selectedColor.opacity(opacity))
////                                    .frame(width: size, height: size)
//////                            } else {
//////                                RoundedRectangle(cornerRadius: 3)
//////                                    .fill(idx < filledCount ? selectedColor : unselectedColor)
//////                                    .frame(width: size, height: size)
//////                            }
////                        }
////                    }
////                }
//                
//                
//                ForEach(0..<totalRows, id: \.self) { index in
//                    let opacity = index < values.count ? values[index] : 0.0
//                    RoundedRectangle(cornerRadius: 3)
//                        .fill(selectedColor.opacity(opacity))
//                        .frame(width: size, height: size)
//                }
//            }
//        }
//        .aspectRatio(CGFloat(totalCols) / CGFloat(totalRows), contentMode: .fit)
//        .onAppear {
//            unselectedColor = selectedColor.opacity(baseOpacity)
//        }
//    }
//    
//    /// Maps [threshold .. 100] → [baseOpacity .. 1]
//    private func opacity(for value: Int) -> Double {
//        let threshold = baseOpacity * 100  // e.g. 0.2 → 20, 0.3 → 30
//        let clamped = max(threshold, min(100, Double(value)))
//        let progress = (clamped - threshold) / (100 - threshold) // normalize
//        return baseOpacity + progress * (1 - baseOpacity)
//    }
//}
//
//
//
//struct HeatmapRow_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(spacing: 20) {
//            GridTileView(itemType: .arc, values: (0..<1).map { _ in Int.random(in: 0...100) }, filledCount: 1, selectedColor: .appYellow)
//                .frame(height: 20)
//            GridTileView(itemType: .arc, values: (0..<5).map { _ in Int.random(in: 0...100) }, filledCount: 5, selectedColor: .appBlue)
//                .frame(height: 20)
//            GridTileView(itemType: .arc, values: (0..<14).map { _ in Int.random(in: 0...100) }, filledCount: 14, selectedColor: .appPurple)
//                .frame(height: 20)
//        }
//        .padding()
//        .background(Color.black)
//    }
//}


//import SwiftUI
//
//struct GridTileView: View {
//    let itemType: ItemType
//    let values: [Double]
//    let selectedColor: Color
//    
//    private let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 20)
//    private let totalCells = 100
//    
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyVGrid(columns: columns, spacing: 5) {
//                ForEach(0..<totalCells, id: \.self) { index in
//                    // Flip vertically so filling starts at top-left
//                    let flippedIndex = index % 20 + (4 - index / 20) * 20
//                    
//                    let opacity = flippedIndex < values.count ? values[flippedIndex] : 0.0
//                    RoundedRectangle(cornerRadius: 3)
//                        .fill(selectedColor.opacity(opacity))
//                        .frame(width: 15, height: 15)
//                }
//            }
//        }
//    }
//}


import SwiftUI

struct GridTileView: View {
    let itemType: ItemType
    let values: [Double]
    let selectedColor: Color
    
    private let columnsCount = 20
    private let rowsCount = 5
    private let spacing: CGFloat = 4
    private let gridHeight: CGFloat = 80
    
    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
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
            .frame(height: gridHeight, alignment: .top)
            .frame(width: totalWidth, alignment: .center)
            .position(x: geo.size.width / 2, y: gridHeight / 2)
        }
        .frame(height: gridHeight)
    }
}
