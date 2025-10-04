import Foundation
import SwiftUI

// MARK: - SnapAlignmentHelper

struct SnapAlignmentHelper<ID: Hashable, Content: View>: View {
    @EnvironmentObject var sizeOverride: SizeOverride

    var id: ID
    var coordinateSpace: String?
    var content: Content
    
    init(id: ID, coordinateSpace: String?, content: Content) {
        self.id = id
        self.coordinateSpace = coordinateSpace
        self.content = content
    }
    
    var body: some View {
        if let width = sizeOverride.itemWidth {
            content
                .frame(width: width)
                .overlay(GeometryReaderOverlay(id: id, coordinateSpace: coordinateSpace))
        } else {
            content
                .overlay(GeometryReaderOverlay(id: id, coordinateSpace: coordinateSpace))
        }
    }
}

// Extension to provide the same API as before
extension View {
    public func snapAlignmentHelper<ID: Hashable>(
        id: ID,
        coordinateSpace: String? = .none) -> some View {
        
        SnapAlignmentHelper(id: id, coordinateSpace: coordinateSpace, content: self)
    }
}
