//
//  Route.swift
//  HabitTracker
//
// Created by Mayur Shrivas on 25/08/25.
//
import SwiftUI
import Foundation

enum Route: Hashable {
    case arcDetail(id: String)
    case allArcsView(title: String)
    case allHabitsView
    case arcDetailPreJoinView(arcTemplate: ArcTemplate)
}

extension Route: View {
    var body: some View {
        switch self {
        case .arcDetail(let id):
            ArcDetailView(arcID: id)
        case .allArcsView(let title):
            AllArcsView(title: title)
        case .allHabitsView:
            AllHabitsView()
        case .arcDetailPreJoinView(let arcTemplate):
            ArcDetailPreJoinView(arc: arcTemplate)
        }
    }
}

