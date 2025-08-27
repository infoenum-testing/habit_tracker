//
//  DailyHabitsCellView.swift
//  HabitTracker
//
//  Created by ie15 on 26/08/25.
//

import SwiftUI

struct DailyHabitsCellView: View {
    var icon: String = "apple"
    var body: some View {
        
            HStack(alignment: .center, spacing: 10){
                ZStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 51.471, height: 51.072)
                      .background(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2))
                      .cornerRadius(9.2)
                    
                    Image(icon)
                      .frame(width: 22.05, height: 22.05)
                }
                .frame(width: 51.471, height: 51.072)
                
                HStack(alignment: .center, spacing: 10.8732) {
                    VStack(alignment: .center, spacing: 5.29808) {
                        Text("Task 1")
                            .font(Font.sfPro(size: 17, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text("Little description")
                        .font(Font.sfPro(size: 14))
                          .foregroundColor(.white.opacity(0.6))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(.appPurple)
                      .frame(width: 51.471, height: 51.072)
                      .background(Color(red: 0.61, green: 0.64, blue: 0.69).opacity(0.2))
                      .cornerRadius(9.2)
                    
                    Image("check")
                      .frame(width: 22, height: 22)
                      
                }
                .frame(width: 51.471, height: 51.072)
            }
            .padding(.leading, 11.2)
            .padding(.trailing, 19.2)
            .padding(.vertical, 19.2)
            .frame(maxWidth: .infinity, minHeight: 73, maxHeight: 73, alignment: .leading)
            .background(Color.cellBackgroundColor)
            .cornerRadius(10.4)
        
    }
}

#Preview {
    DailyHabitsCellView()
}
