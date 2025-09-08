//
//  HeaderView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text(StringConstants.Statistic.statistics)
                .font(.sfProDisplay(.semibold, size: 22))
            Spacer()
        }
    }
}

#Preview {
    HeaderView()
}
