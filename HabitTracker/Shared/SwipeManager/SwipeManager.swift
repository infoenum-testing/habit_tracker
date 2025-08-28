//
//  SwipeManager.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//

import SwiftUI
import Foundation


class SwipeManager: ObservableObject {
    @Published var openRowID: String? = nil
    
    func closeAll() {
        openRowID = nil
    }
}
