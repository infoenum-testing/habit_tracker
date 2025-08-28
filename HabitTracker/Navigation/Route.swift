//
//  Route.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//
import SwiftUI
import Foundation

enum Route: Hashable {
    case arcDetail(id: String)
    case allArcsView
    case allHabitsView
    case arcDetailPreJoinView(arcTemplate: ArcTemplate)
}

extension Route: View {
    var body: some View {
        switch self {
        case .arcDetail(let id):
            ArcDetailView(arcID: id)
        case .allArcsView:
            AllArcsView()
        case .allHabitsView:
            AllHabitsView()
        case .arcDetailPreJoinView(let arcTemplate):
            ArcDetailPreJoinView(arc: arcTemplate)
        }
    }
}

