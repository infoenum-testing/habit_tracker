//
//  NavigationRouter.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 25/08/25.
//
import SwiftUI
import Foundation

final class NavigationRouter: ObservableObject {
    @Published var routes = [Route]()
    @Published var dismissAllSheets = false


    func push(to screen: Route) {
        routes.append(screen)
    }

    func popToRoot() {
        routes = []
    }

    func pop() {
        _ = routes.popLast()
    }
    
    func dismissAll() {
            dismissAllSheets = true
            DispatchQueue.main.async {
                self.dismissAllSheets = false
            }
        }
}
