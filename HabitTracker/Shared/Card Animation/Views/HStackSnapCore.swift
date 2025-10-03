import Foundation
import SwiftUI

public typealias SnapToScrollEventHandler = ((SnapToScrollEvent) -> Void)

public struct HStackSnapCore<Content: View>: View {
    // MARK: - Public Init

    public init(
        selectedIndex: Binding<Int>,
        layoutRefreshTrigger: Binding<Int>,
        selectedLeadingOffset: CGFloat,
        shouldAutoScrollCard: Bool,
        leadingOffset: CGFloat,
        spacing: CGFloat? = nil,
        coordinateSpace: String = "SnapToScroll",
        @ViewBuilder content: @escaping () -> Content,
        eventHandler: SnapToScrollEventHandler? = .none
    ) {
        self._selectedIndex = selectedIndex
        self._layoutRefreshTrigger = layoutRefreshTrigger
        self.content = content
        self.targetOffset = leadingOffset
        self.selectedLeadingOffset = selectedLeadingOffset
        self.spacing = spacing
        self.scrollOffset = leadingOffset
        self.coordinateSpace = coordinateSpace
        self.eventHandler = eventHandler
        self.shouldAutoScrollCard = shouldAutoScrollCard
        self._prevScrollOffset = State(initialValue: leadingOffset)
    }

    // MARK: - Public Body

    public var body: some View {
        GeometryReader { geometry in
            HStack {
                HStack(spacing: spacing, content: content)
                    .offset(x: scrollOffset - selectedLeadingOffset, y: .zero)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .id(layoutRefreshTrigger)
            .onPreferenceChange(ContentPreferenceKey.self) { preferences in
                self.preferences = preferences

                if !hasCalculatedFrames {
                    let screenWidth = geometry.frame(in: .named(coordinateSpace)).width

                    var itemScrollPositions: [Int: CGFloat] = [:]
                    var frameMaxXVals: [CGFloat] = []

                    for (index, preference) in preferences.enumerated() {
                        itemScrollPositions[index] = scrollOffset(for: preference.rect.minX)
                        frameMaxXVals.append(preference.rect.maxX)
                    }

                    var contentFitMap: [CGFloat] = []
                    for currMinX in preferences.map({ $0.rect.minX }) {
                        guard let maxX = preferences.last?.rect.maxX else { break }
                        let widthToEnd = maxX - currMinX
                        contentFitMap.append(widthToEnd)
                    }

                    var frameTrim: Int = 0
                    let reversedFitMap = Array(contentFitMap.reversed())
                    for i in 0..<reversedFitMap.count {
                        if reversedFitMap[i] > screenWidth {
                            frameTrim = max(i - 1, 0)
                            break
                        }
                    }

                    for (i, item) in itemScrollPositions.sorted(by: { $0.value > $1.value }).enumerated() {
                        guard i < (itemScrollPositions.count - frameTrim) else { break }
                        snapLocations[item.key] = item.value
                    }

                    hasCalculatedFrames = true
                    eventHandler?(.didLayout(layoutInfo: itemScrollPositions))

                    if shouldAutoScrollCard,
                       snapLocations.count > 1,
                       selectedIndex != snapLocations.count,
                       let nextOffset = snapLocations[selectedIndex] {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(.easeOut(duration: 0.3)) {
                                scrollOffset = nextOffset
                            }
                            prevScrollOffset = nextOffset
                            eventHandler?(.swipe(index: selectedIndex))
                        }
                    } else if snapLocations.count > 1,
                                selectedIndex != snapLocations.count,
                                let nextOffset = snapLocations[selectedIndex] {
                        scrollOffset = nextOffset
                        prevScrollOffset = nextOffset
                        eventHandler?(.swipe(index: selectedIndex))
                    }
                }
            }
            .onChange(of: selectedIndex) { newValue in
                if let offset = snapLocations[newValue] {
                    withAnimation(.easeOut(duration: 0.3)) {
                        scrollOffset = offset
                        prevScrollOffset = offset
                    }
                    eventHandler?(.swipe(index: newValue))
                }
            }
            .contentShape(Rectangle())
            .gesture(snapDrag)
        }
        .coordinateSpace(name: coordinateSpace)
    }

    // MARK: - Gesture

    var snapDrag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                let currentTime = Date().timeIntervalSince1970
                let timeDifference = currentTime - lastUpdateTime

                if timeDifference > 0.05 {
                    lastUpdateTime = currentTime
                    eventHandler?(.didEndUserInteraction(hasEnd: false))
                }
            }
            .onEnded { gesture in
                eventHandler?(.didEndUserInteraction(hasEnd: true))
                let dragDistance = gesture.translation.width
                let currOffset = scrollOffset

                guard let itemWidth = preferences.first?.rect.width else { return }
                let threshold = itemWidth * 0.1
                let direction: Int = dragDistance < 0 ? 1 : -1
                let currentIndex = selectedIndex
                let newIndex: Int

                if abs(dragDistance) > threshold {
                    newIndex = max(0, min(currentIndex + direction, snapLocations.count - 1))
                } else {
                    newIndex = currentIndex
                }

                if let newSnapOffset = snapLocations[newIndex] {
                    if newIndex != selectedIndex {
                        selectedIndex = newIndex
                        eventHandler?(.swipe(index: newIndex))
                    }

                    withAnimation(.easeOut(duration: 0.2)) {
                        scrollOffset = newSnapOffset
                    }
                    prevScrollOffset = newSnapOffset
                }
            }
    }

    // MARK: - Helper

    func scrollOffset(for x: CGFloat) -> CGFloat {
        return (targetOffset * 2) - x
    }

    // MARK: - Private State

    var content: () -> Content

    @Binding private var selectedIndex: Int
    @Binding private var layoutRefreshTrigger: Int
    
    @State private var preferences: [ContentPreferenceData] = [] {
        didSet {
            if oldValue.map(\.id) != preferences.map(\.id) || oldValue.map { $0.rect.size } != preferences.map { $0.rect.size } {
                hasCalculatedFrames = false
            }
        }
    }
    @State private var hasCalculatedFrames: Bool = false
    @State private var scrollOffset: CGFloat
    @State private var prevScrollOffset: CGFloat
    @State private var targetOffset: CGFloat
    @State private var spacing: CGFloat?
    @State private var snapLocations: [Int: CGFloat] = [:]
    @State private var lastUpdateTime: TimeInterval = 0

    private let coordinateSpace: String
    private let selectedLeadingOffset: CGFloat
    private let eventHandler: SnapToScrollEventHandler?
    private let shouldAutoScrollCard: Bool
}
