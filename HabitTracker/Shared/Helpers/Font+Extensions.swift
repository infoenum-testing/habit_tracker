//
//  Font+Extensions.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

extension Font {
    static func sfProDisplay(_ style: SFProDisplayStyle, size: CGFloat) -> Font {
        .custom(style.rawValue, size: size)
    }

    enum SFProDisplayStyle: String {
        case light = "SFProDisplay-Light"
        case regular = "SFProDisplay-Regular"
        case medium = "SFProDisplay-Medium"
        case semibold = "SFProDisplay-Semibold"
        case bold = "SFProDisplay-Bold"
        case black = "SFProDisplay-Black"
        //Italic styles
        case ultralightItalic = "SFProDisplay-UltralightItalic"
        case thinItalic = "SFProDisplay-ThinItalic"
        case lightItalic = "SFProDisplay-LightItalic"
        case regularItalic = "SFProDisplay-RegularItalic"
        case semiboldItalic = "SFProDisplay-SemiboldItalic"
        case heavyItalic = "SFProDisplay-HeavyItalic"
        case blackItalic = "SFProDisplay-BlackItalic"
    }
}

extension Font {
    enum FlowerOfNineties: String {
        case semiboldItalic = "FlowersOfNineties-SmboldItalic"
    }

    static func flowerOfNineties(_ style: FlowerOfNineties, size: CGFloat) -> Font {
        .custom(style.rawValue, size: size)
    }
}
