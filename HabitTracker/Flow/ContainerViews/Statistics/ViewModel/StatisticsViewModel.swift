//
//  StatisticsViewModel.swift
//  HabitTracker
//
//  Created by IE14 on 04/10/25.
//


import Foundation
import SwiftUI

final class StatisticsViewModel: ObservableObject {
    @Published var showInfoPopup: Bool = false
    @Published var completedArcs: [(History, Int)] = []
    
}
