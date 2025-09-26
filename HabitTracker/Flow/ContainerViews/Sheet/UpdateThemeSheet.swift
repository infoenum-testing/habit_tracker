//
//  UpdateThemeSheet.swift
//  HabitTracker
//
//  Created by IE14 on 26/09/25.
//


import SwiftUI

struct UpdateThemeSheet: View {
    @Binding var isPresented: Bool
    @State private var selectedColor: String = ""
    @State private var showConfirmation = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var navigation: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    let arcId: String = ""
    let habitId: String = ""
    
    private let colorsArray: [String] = AppColors.all
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 119, height: 5)
                        .background(.white.opacity(0.2))
                        .cornerRadius(15)
                    Spacer()
                }
                .padding(.top,19)
                
                
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(AppColors.all, id: \.self) { icon in
                                let isSelected = icon == selectedColor
                                let width: CGFloat = isSelected ? 50 : 34
                                let height: CGFloat = isSelected ? 50 : 34
                                VStack {
                                    Image(icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                                .frame(width: width, height: height)
                                .background(Color.white.opacity(0.10))
                                .cornerRadius(width / 2)
                                .background(
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: selectedColor == icon ? 3 : 0)
                                )
                                .id(icon)
                                .onTapGesture {
                                    withAnimation {
                                        selectedColor = icon
                                        proxy.scrollTo(icon, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .task {
                        if let arc = appData.selectedArctoDelete {
                            selectedColor = arc.wrappedThemeColor
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    proxy.scrollTo(selectedColor, anchor: .center)
                                }
                            }
                        }
                    }
//                    .onAppear {
//                        // ensure habit icon is set first
//                       // selectedColor = habit.wrappedColorToken
//                        
//                        // scroll AFTER a tiny delay (so layout is ready)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                            withAnimation {
//                                proxy.scrollTo(selectedColor, anchor: .center)
//                            }
//                        }
//                    }
                }
                
                
                
            }
            
        }.frame(height: 300)
    }
}
