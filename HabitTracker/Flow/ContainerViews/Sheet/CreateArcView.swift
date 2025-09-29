//
//  CreateArcView.swift
//  HabitTracker
//
//  Created by IE14 on 29/09/25.
//

import SwiftUI

struct CreateArcView: View {
    @State private var selectedColor: Int = 2
    @State private var habits: [String] = ["Habit #1", "Habit #2"]
    @State private var arcDuration: String = "15 days"
    
    let colors: [Color] = [.orange, .red, .yellow, .green, .purple, .blue]
    
    var body: some View {
        VStack(spacing: 20) {
            // Color selector
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(colors.indices, id: \.self) { index in
                        Circle()
                            .fill(colors[index])
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .strokeBorder(Color.white, lineWidth: selectedColor == index ? 3 : 0)
                            )
                            .onTapGesture {
                                selectedColor = index
                            }
                    }
                }
                .padding(.top, 10)
            }
            
            // Title
            Text("My New Arc")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Divider().background(Color.white.opacity(0.2))
            
            // Habits list
            VStack(spacing: 12) {
                ForEach(habits.indices, id: \.self) { index in
                    HStack {
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 2)
                            .frame(width: 18, height: 18)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(habits[index])
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                            Text("Describe your habit")
                                .font(.system(size: 13))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // edit action
                        }) {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(12)
                }
                
                // Add new habit button
                Button(action: {
                    habits.append("Habit #\(habits.count + 1)")
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add new habit")
                    }
                    .foregroundColor(.white.opacity(0.7))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                }
            }
            
            // Arc Duration dropdown
            Menu {
                Button("7 days") { arcDuration = "7 days" }
                Button("15 days") { arcDuration = "15 days" }
                Button("30 days") { arcDuration = "30 days" }
            } label: {
                HStack {
                    Image(systemName: "calendar")
                    Text(arcDuration)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
            }
            
            Spacer()
            
            // Create Arc button
            Button(action: {
                // create arc action
            }) {
                HStack {
                    Spacer()
                    Text("Create Arc")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

struct CreateArcView_Previews: PreviewProvider {
    static var previews: some View {
        CreateArcView()
    }
}
