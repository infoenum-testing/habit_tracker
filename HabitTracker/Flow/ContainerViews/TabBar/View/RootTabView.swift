//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//
import SwiftUI
import Foundation


struct RootTabView: View {
    @EnvironmentObject var state: AppState
    @State private var tab: Int = 0
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            VStack(spacing: 0) {
                switch tab {
                case 0:
                    HomeView()
                case 1:
                    ExploreMain()
                case 2:
                    StatisticsView()
                default:
                    MyAccountView()
                }
                CustomTabBar(tab: $tab)
            }
            .ignoresSafeArea(.keyboard)
            .environmentObject(router)
            .navigationDestination(for: Route.self) { $0 }
        }.navigationBarHidden(true)
        
    }
}


