//
//  ArcRowList.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI
import Foundation


class SwipeManager: ObservableObject {
    @Published var openRowID: UUID? = nil
    
    func closeAll() {
        openRowID = nil
    }
}

struct SwipeableRow<Content: View, Actions: View>: View {
    let id: UUID
    let buttonWidth: CGFloat
    let actions: Actions
    let content: Content
    
    @EnvironmentObject var swipeManager: SwipeManager
    
    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    init(
        id: UUID,
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
                .cornerRadius(offset == 0 ? 14 : 0)
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
//                .onTapGesture {
//                    withAnimation(.spring()) {
//                        swipeManager.closeAll()
//                    }
//                }
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




struct ArcRowList: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var swipeManager: SwipeManager

    let arc: Arc
    
    var body: some View {
        SwipeableRow(
                    id: arc.id,
                    actions: {
                        Button(action: {
                            print("Edit tapped for \(arc.title)")
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    },
                    content: {
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        IconBadge(icon: arc.icon, tint: arc.color)
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(arc.title)
                                .font(.sfProDisplay(.semibold, size: 19))
                            Text("Day \(arc.dayNumber)")
                                .font(.sfProDisplay(.light, size: 14))
                                .opacity(0.7)
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        CounterPill(
                            text: "\(arc.completedCount)/\(arc.totalCount)",
                            tint: arc.color,
                            completed: arc.completedCount,
                            total: arc.totalCount
                        )
                        .padding(.trailing)
                    }
                    .frame(height: 70)
                    
                    
                    if state.layout == .grid {
                        GridTileView(itemType: .arc,
                                     values: arc.history,
                                     filledCount: arc.completedArc,
                                     selectedColor: arc.color)
                        .frame(height: 100)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            arc.color.opacity(0.18),
                            arc.color.opacity(0.28),
                            arc.color.opacity(0.38),
                            arc.color.opacity(0.48)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .background(.black)
                .cornerRadius(swipeManager.openRowID == arc.id ? 0 : 14)
                .overlay(
                    RoundedRectangle(cornerRadius: swipeManager.openRowID == arc.id ? 0 : 14, style: .continuous)
                        .stroke(arc.color, lineWidth: 1)
                )
            }
        )
    }
}
