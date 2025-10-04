//
//  UIFont+extension.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 25/08/25.
//

import Foundation
import SwiftUI

extension Font {
    
    static var interReguler = Font.inter(size: 18);
    
    
    static func inter(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .regular:
            return Font.custom("Inter18pt-Regular", size: size)
        case .bold:
            return Font.custom("Inter18pt-Bold", size: size)
        case .semibold:
            return Font.custom("Inter18pt-SemiBold", size: size)
        default:
            return Font.custom("Inter18pt-Regular", size: size)
        }
        
    }
    
    static func sfPro(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .regular:
            return Font.custom("SFProDisplay-Regular", size: size)
        case .semibold:
            return Font.custom("SFProDisplay-Semibold", size: size)
        case .bold:
            return Font.custom("SFProDisplay-Bold", size: size)
        case .medium:
            return Font.custom("SFProDisplay-Medium", size: size)
        default:
            return Font.custom("SFProDisplay-Regular", size: size)
        }
    }
    
    static func NotCourierSans(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .bold:
            return Font.custom("NotCourierSans-Bold", size: size)
        default:
            return Font.custom("SFProDisplay-Regular", size: size)
        }
    }
}
