//
//  FlowLayout.swift
//  HabitTracker
//
//  Created by Apple on 02/09/25.
//

import SwiftUI


struct FlowLayout: View {
    @State public var tags: [String]
    @State private var contentHeight: CGFloat = .zero
    //var seeAll: () -> Void
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
                .background(
                    GeometryReader { innerGeometry in
                        Color.clear
                            .onAppear {
                                self.contentHeight = innerGeometry.size.height
                            }
                    }
                )
        }
        .frame(height: contentHeight)

    }


    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if tag == self.tags.last {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if tag == self.tags.last {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    private func item(for text: String) -> some View {
        return TextBadgeViewForGutHealth(title: text, foregroundColor: .white, icon: "check")
            .background(Color.white.opacity(0.14))
            .cornerRadius(20)
        
    }
}

#Preview {
    FlowLayout(tags: ["", ""])
}
