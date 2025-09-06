//
//  SectionTitle.swift
//  HabitTracker
//
//  Created by Apple on 06/09/25.
//

import SwiftUI

struct SectionTitle: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.sfProDisplay(.medium, size: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SectionTitle("")
}
