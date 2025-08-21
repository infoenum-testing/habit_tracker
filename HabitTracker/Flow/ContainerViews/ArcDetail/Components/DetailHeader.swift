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
                CircleButton(icon: "back", action: {
                    backButtonTapped()
                })
                Spacer()
                CircleButton(icon: "pencil", action: {
                    editButtonTapped()
                })
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
           
        }
    }
}


