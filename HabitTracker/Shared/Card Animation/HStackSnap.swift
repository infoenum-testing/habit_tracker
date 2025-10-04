import Foundation
import SwiftUI

public struct HStackSnap<Content: View>: View {

    @Binding var selectedIndex: Int
    @Binding var layoutRefreshTrigger: Int

    // MARK: Lifecycle

    public init(
        selectedIndex: Binding<Int>,   
        layoutRefreshTrigger: Binding<Int>,
        selectedLeadingOffset: CFloat,
        nextCardIndex: Int,
        shouldAutoScrollCard: Bool,
        alignment: SnapAlignment,
        spacing: CGFloat? = nil,
        coordinateSpace: String = "SnapToScroll",
        @ViewBuilder content: @escaping () -> Content,
        eventHandler: SnapToScrollEventHandler? = .none) {
            self._selectedIndex = selectedIndex
            self._layoutRefreshTrigger = layoutRefreshTrigger
            self.selectedLeadingOffset = CGFloat(selectedLeadingOffset)
            self.content = content
            self.alignment = alignment
            self.leadingOffset = alignment.scrollOffset
            self.nextCardIndex = nextCardIndex
            self.shouldAutoScrollCard = shouldAutoScrollCard
            self.spacing = spacing
            self.coordinateSpace = coordinateSpace
            self.eventHandler = eventHandler
    }

    // MARK: Public

    public var body: some View {
        
        func calculatedItemWidth(parentWidth: CGFloat, offset: CGFloat) -> CGFloat {
            return parentWidth - offset * 2
        }

        return GeometryReader { geometry in

            HStackSnapCore(
                selectedIndex: $selectedIndex,
                layoutRefreshTrigger: $layoutRefreshTrigger,
                selectedLeadingOffset: selectedLeadingOffset,
                shouldAutoScrollCard: shouldAutoScrollCard,
                leadingOffset: leadingOffset,
                spacing: spacing,
                coordinateSpace: coordinateSpace,
                content: content,
                eventHandler: eventHandler)
                .environmentObject(SizeOverride(itemWidth: alignment.shouldSetWidth ? calculatedItemWidth(parentWidth: geometry.size.width, offset: alignment.scrollOffset) : .none))
        }
    }

    // MARK: Internal

    var content: () -> Content

    // MARK: Private
    
    private let alignment: SnapAlignment

    /// Calculated offset based on `SnapLocation`
    private let leadingOffset: CGFloat
    private let nextCardIndex: Int
    private let shouldAutoScrollCard: Bool

    private let spacing: CGFloat?

    private var eventHandler: SnapToScrollEventHandler?

    private let coordinateSpace: String
    @State var selectedLeadingOffset: CGFloat
}
