//
//  PlaceholderView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import SwiftUI

struct PlaceholderView: View {
    var text: String
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text(text)
                .foregroundStyle(.white)
        }
    }
}

