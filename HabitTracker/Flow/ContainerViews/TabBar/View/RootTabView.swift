//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//
import SwiftUI
import Foundation


struct RootTabView: View {
    @EnvironmentObject var state: AppDataStore
    //@State private var tab: Int = 0
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            VStack(spacing: 0) {
                switch router.tab {
                case 0:
                    HomeView()
                case 1:
                   // ExploreMain()
                     NewExploreMain()
                case 2:
                    StatisticsView()
                default:
                    MyAccountView()
                }
                CustomTabBar(tab: $router.tab)
            }
            .ignoresSafeArea(.keyboard)
            .navigationDestination(for: Route.self) { $0 }
        }.navigationBarHidden(true)
    }
}


