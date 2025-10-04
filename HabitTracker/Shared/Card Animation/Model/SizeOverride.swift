import Foundation
import SwiftUI

class SizeOverride: ObservableObject {
    
    @Published var itemWidth: CGFloat?
    
    init(itemWidth: CGFloat? = nil) {
        self.itemWidth = itemWidth
    }
}
