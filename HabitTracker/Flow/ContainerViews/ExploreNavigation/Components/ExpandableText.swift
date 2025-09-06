//
//  ExpandableText.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 02/09/25.
//

import SwiftUI


struct ExpandableText: View {
    
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    private var text: String
    let font: UIFont
    let lineLimit: Int
    
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? " less" : " ...more"
        }
    }
    
    init(_ text: String, lineLimit: Int, font: UIFont = UIFont(name: "SFProDisplay-Regular", size: 14) ?? .systemFont(ofSize: 14)) {
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText =  State(wrappedValue: text)
        self.font = font
    }
    
    var body: some View {
        
        
        ZStack(alignment: .bottomLeading) {
            Group {
                Text(self.expanded ? text : shrinkText)
                    .font(Font.sfPro(size: 14))
                    .foregroundColor(Color.white.opacity(0.5))
                + Text(moreLessText)
                    .font(Font.sfPro(size: 14))
                    .foregroundColor(Color.white)
                
            }
            .lineLimit(expanded ? nil : lineLimit)
            .background(
                // Render the limited text and measure its size
                Text(text)
                    .font(Font.sfPro(size: 14))
                    .foregroundStyle(Color.white.opacity(0.5))
                    .lineLimit(lineLimit)
                    .background(GeometryReader { visibleTextGeometry in
                        Color.clear.onAppear() {
                            let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                            let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
                            ///Binary search until mid == low && mid == high
                            var low  = 0
                            var heigh = shrinkText.count
                            var mid = heigh ///start from top so that if text contain we does not need to loop
                            while ((heigh - low) > 1) {
                                let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                if boundingRect.size.height > visibleTextGeometry.size.height {
                                    truncated = true
                                    heigh = mid
                                    mid = (heigh + low)/2
                                    
                                } else {
                                    if mid == text.count {
                                        break
                                    } else {
                                        low = mid
                                        mid = (low + heigh)/2
                                    }
                                }
                                shrinkText = String(text.prefix(mid))
                            }
                            if truncated {
                                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  
                            }
                        }
                    })
                    .hidden()
            )
            .font(Font(font))
            if truncated {
                Button(action: {
                    expanded.toggle()
                }, label: {
                    HStack {
                        Spacer()
                        Text("")
                    }.opacity(0)
                })
            }
        }
    }
}

