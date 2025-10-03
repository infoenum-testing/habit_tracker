//
//  CardSwitcherView.swift
//  HabitTracker
//
//  Created by ie13 on 30/09/25.

import SwiftUI

struct CardSwitcherView: View {
    
    @Binding var selectedCard: Int
    @Binding var showBorderAnimation: Bool
    @State private var layoutRefreshTrigger: Int = 0
    let array: [[String: Any]] = [
        ["title": "Text", "des" : "DAY 24/30\nGUT HEALTH ARC\n$225 CHALLENGE", "isGrid": false],
        ["title": "Grid", "des" : "DAY 24/30\nGUT HEALTH ARC\n$225 CHALLENGE", "isGrid": true]
    ]
    @State private var isSelectedText: Bool = true
    @State private var isSelectedGrid: Bool = false

    var body: some View {
        VStack {
            // Card container
            Text(array[selectedCard]["title"] as? String ?? "Card")
                .font(.inter(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.white.opacity(0.06))
                .cornerRadius(8)
                .padding(.top, 28)
                .padding(.bottom, 28)
            
            HStackSnap(selectedIndex: $selectedCard, layoutRefreshTrigger: $layoutRefreshTrigger , selectedLeadingOffset: 0, nextCardIndex: 0, shouldAutoScrollCard: false , alignment: .center(50)) {
                ForEach(Array(array.enumerated()), id: \.offset) { index, element in
                    if let isGrid = element["isGrid"]as? Bool, let des = element["des"] as? String {
                        CardView(description: des, bgColor: Color.black , scale: CGSize(width: selectedCard == index ? 1.0 : 0.93,height: selectedCard == index ? 1.0 : 0.93), isGrid: isGrid , shouldShowAnimation: selectedCard == index  ? $showBorderAnimation : .constant(false))
                            .tag(index)
                            .snapAlignmentHelper(id: index)
                    }
                }
            } eventHandler: { event in
                handleSnapToScrollEvent(event: event)
            }
            .frame(height: 360)
            .frame(width: UIScreen.main.bounds.width)
            .padding(.bottom, 15)
            
            // Bottom buttons
            HStack(spacing: 50) {
                SelectionOptionCellView(imageName: "textAlignment", title: "Text", isSelected: isSelectedText) {
                    selectedCard = 0
                    isSelectedText  = true
                    isSelectedGrid = false
                }
                SelectionOptionCellView(imageName: "gridIcon", title: "Grid", isSelected: isSelectedGrid) {
                    selectedCard = 1
                    isSelectedText = false
                    isSelectedGrid = true
                }
            }
        }
    }
    
    func handleSnapToScrollEvent(event: SnapToScrollEvent) {
        switch event {
        case .didLayout(layoutInfo: _):
            break
        case let .swipe(index: index):
            selectedCard = index
            isSelectedText = index == 0
            isSelectedGrid = index == 1
        case .didEndUserInteraction(hasEnd: _):
            break
        }
    }
}
