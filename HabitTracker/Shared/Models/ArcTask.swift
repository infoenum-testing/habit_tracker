//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI

struct ArcTask: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String
    var icon: String
    var color: Color
    var isCompleted: Bool
}

