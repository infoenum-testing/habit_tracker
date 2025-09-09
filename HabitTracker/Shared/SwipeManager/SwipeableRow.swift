//
//  SwipeableRow.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 25/08/25.
//

import SwiftUI
import Foundation

struct SwipeableRow<Content: View, Actions: View>: View {
    let id: String
    let buttonWidth: CGFloat
    let actions: Actions
    let content: Content
    
    @EnvironmentObject var swipeManager: SwipeManager
    
    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    init(
        id: String,
        buttonWidth: CGFloat = 80,
        @ViewBuilder actions: () -> Actions,
        @ViewBuilder content: () -> Content
    ) {
        self.id = id
        self.buttonWidth = buttonWidth
        self.actions = actions()
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Hidden action buttons
            HStack(spacing: 0) {
                actions
                    .frame(width: buttonWidth)
                Spacer()
            }
            
            // Main content
            content
            
                .offset(x: currentOffset)
                .simultaneousGesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if abs(value.translation.width) > abs(value.translation.height),
                               value.translation.width > 0 {
                                state = value.translation.width
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if value.translation.width > buttonWidth / 2 {
                                    swipeManager.openRowID = id
                                } else {
                                    swipeManager.closeAll()
                                }
                            }
                        }
                )
        }
        .onChange(of: swipeManager.openRowID) { newValue in
            // Close this row if another row is opened
            if newValue != id {
                withAnimation(.spring()) {
                    offset = 0
                }
            } else {
                withAnimation(.spring()) {
                    offset = buttonWidth - 15
                }
            }
        }
    }
    
    private var currentOffset: CGFloat {
        if swipeManager.openRowID == id {
            return min(offset + dragOffset, buttonWidth - 10)
        } else {
            return 0
        }
    }
}
