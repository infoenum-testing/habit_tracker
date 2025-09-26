//
//  Untitled.swift
//  HabitTracker
//
//  Created by IE14 on 26/09/25.
//

import SwiftUI

struct CategoriesView: View {
    let categories = [
        ("Mind", 9, "Mind"),
        ("Body", 9, "Body"),
        ("Lifestyle", 10, "Lifestyle"),
        ("Modes", 8, "Modes")
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    var onCategorySelected: (String, Int, String) -> Void
    var body: some View {
        VStack(spacing: 10) {
            Text("View Categories")
                .font(.sfProDisplay(.medium, size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(categories, id: \.0) { item in
                        CategoryCell(title: item.0,
                                     arcsCount: item.1,
                                     backgroundImage: item.2) {
                            onCategorySelected(item.0, item.1, item.2)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
    }
}






