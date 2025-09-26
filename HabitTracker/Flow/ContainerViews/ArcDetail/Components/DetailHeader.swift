//
//  DetailHeader.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct DetailHeader: View {
    var title: String
    var day: Int
    var backButtonTapped: () -> Void
    var editButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                RoundBackButton(iconColor: .white,backgroundColor: .black.opacity(0.65), action: {
                    backButtonTapped()
                })
                Spacer()
                RoundBackButton(icon: StringConstants.Image.shareIcon,iconColor: .white, backgroundColor: .black.opacity(0.65), action: {
                    editButtonTapped()
                })
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
            
        }
    }
}


