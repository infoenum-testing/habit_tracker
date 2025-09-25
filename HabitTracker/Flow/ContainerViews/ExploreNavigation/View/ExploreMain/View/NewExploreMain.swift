//
//  NewExploreMain.swift
//  HabitTracker
//
//  Created by IE14 on 24/09/25.
//

import SwiftUI

struct NewExploreMain: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appData: AppDataStore
    @State private var isArkSelected: Bool = true
    @State private var showAddHabitSheet: Bool = false
    @State var selectedHabit: HabitTemplate? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
            VStack(alignment: .leading) {
                ExploreHeaderView(isArkSelected: $isArkSelected)
            }
            
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color.navBackground)
            .padding(.horizontal, -24)
            DashedLine()
            
            searchView
                .padding(.top, 20)
                
                HStack {
                    Text(isArkSelected ? StringConstants.ExploreNavigation.trendingArcs : StringConstants.ExploreNavigation.trendingHabits)
                        .font(.sfProDisplay(.medium, size: 14))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        router.push(to: .allArcsView)
                    } label: {
                        Text(StringConstants.ExploreNavigation.viewAll)
                            .font(.sfProDisplay(.medium, size: 14))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
            
            ScrollView {
                VStack(spacing: 15) {
                    if isArkSelected {
                        ForEach(appData.allArcs.prefix(4), id: \.id) { arc in
                            Button {
                                
                            } label: {
                                NewArcsCell(arc: arc)
                                    .onTapGesture {
                                        router.push(to: .arcDetailPreJoinView(arcTemplate: arc))
                                    }
                            }
                        }
                    } else {
                        ForEach(appData.allHabits.prefix(4), id: \.id) { habit in
                            
                            Button {
                            } label: {
                                NewHabitCardCell(habit: habit, addAction: {
                                    showAddHabitSheet = true
                                }, selectedHabit: $selectedHabit)
                            }
                        }
                    }
                }
            }.padding(.top, 15)
        }.padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.sheetBackgroundColor.ignoresSafeArea())
        
        
        .sheet(item: $selectedHabit) { habit in
            AddHabitSheet(habit: habit)
                .presentationDetents([.height(400)])
                .presentationCornerRadius(24)
                .presentationBackground {
                    Color(UIColor.systemBackground)
                }
        }
    }
}

extension NewExploreMain {
    private var searchView: some View {
        
        VStack(spacing: 25) {
            
            HStack {
                Image( StringConstants.Image.magnifyingGlass)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                
                TextField("Search arc...", text: .constant(""))
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                    
                
                Image(StringConstants.Image.vector)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.searchBarColur)
            .cornerRadius(17)

//            HStack {
//                Text(StringConstants.ExploreNavigation.trendingArcs)
//                    .font(.sfProDisplay(.medium, size: 14))
//                    .foregroundColor(.white)
//                
//                Spacer()
//                
//                Button {
//                    router.push(to: .allArcsView)
//                } label: {
//                    Text(StringConstants.ExploreNavigation.viewAll)
//                        .font(.sfProDisplay(.medium, size: 14))
//                        .foregroundColor(.white.opacity(0.5))
//                }
//            }
        }
    }
    

    
    
}

#Preview {
    NewExploreMain()
}






import SwiftUI

struct AddHabitSheet: View {
    
    let habit: HabitTemplate
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    @State private var selectedIcon: String = StringConstants.Image.iconClock
    @State private var selectedColor: String = "color.purple"
    
    private let colorsArray: [String] = AppColors.all
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
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
                            ForEach(AppIcons.all, id: \.self) { icon in
                                let isSelected = icon == selectedIcon
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
                                        .strokeBorder(Color.white, lineWidth: selectedIcon == icon ? 3 : 0)
                                )
                                .id(icon)
                                .onTapGesture {
                                    withAnimation {
                                        selectedIcon = icon
                                        proxy.scrollTo(icon, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onAppear {
                        // ensure habit icon is set first
                        selectedIcon = habit.wrappedIcon
                        
                        // scroll AFTER a tiny delay (so layout is ready)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo(selectedIcon, anchor: .center)
                            }
                        }
                    }
                }
                .frame(height: 50)
                .padding(.vertical, 30)
                
                HStack {
                    Spacer()
                    Text(habit.wrappedTitle)
                        .font(Font.inter(size: 24, weight: .bold))
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.2))
                                .cornerRadius(9)
                                .offset(y: 10)
                        }
                    Spacer()
                }
                .frame(height: 33)
                .padding(.bottom,25)
                
                VStack {
                    HStack(alignment: .top, spacing: 10) {
                        Text(habit.wrappedDetails)
                            .font(Font.inter(size: 12, weight: .light))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(.white.opacity(0.06))
                    .cornerRadius(11)
                }
                .padding(.horizontal)
                .padding(.bottom,50)
                
                ShareProgressButton(title: StringConstants.Sheet.saveHabit) {
                    appData.subscribeToHabit(to: habit) { result in
                        switch result {
                        case .success(_):
                            appData.updateSubscribedHabit(
                                habitID: habit.wrappedId,
                                icon: selectedIcon,
                                newThemeColor: selectedColor
                            ) { success in
                                dismiss()
                            }
                        case .failure(let error):
                            appData.toastMessage = error.localizedDescription
                            appData.showToast = true
                            appData.toastType = .alert
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .frame(height: 400)
    }
}
