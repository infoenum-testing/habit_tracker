//
//  Route.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//
import SwiftUI
import Foundation

enum Route: Hashable {
    case arcDetail(id: UUID)
}

extension Route: View {
    var body: some View {
        switch self {
        case .arcDetail(let id):
            ArcDetailView(arcID: id)
        }
    }
}

