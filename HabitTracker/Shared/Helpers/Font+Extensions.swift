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
    static func openSans(_ style: OpenSans, size: CGFloat) -> Font {
        .custom(style.rawValue, size: size)
    }

    enum OpenSans: String {
        case light = "OpenSans-Light"
        case regular = "OpenSans-Regular"
        case medium = "OpenSans-Medium"
        case semibold = "OpenSans-SemiBold"
        case bold = "OpenSans-Bold"
        case extrabold = "OpenSans-ExtraBold"

        // Italic styles
        case lightItalic = "OpenSans-LightItalic"
        case regularItalic = "OpenSans-Italic" // OpenSans doesn't have "RegularItalic", it's just "Italic"
        case mediumItalic = "OpenSans-MediumItalic"
        case semiboldItalic = "OpenSans-SemiBoldItalic"
        case boldItalic = "OpenSans-BoldItalic"
        case extraboldItalic = "OpenSans-ExtraBoldItalic"
    }
}
