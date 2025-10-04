//
//  CreateHabitView.swift
//  HabitTracker
//
//  Created by IE14 on 29/09/25.
//

import SwiftUI

struct CreateHabitView: View {
    var isFromCreateArc : Bool = false
    @Binding var habit: CreatedHabit
    @State private var tempHabit: CreatedHabit = CreatedHabit(id: UUID(), title: "", description: "", icon: "", color: "")
    @EnvironmentObject var dataStore: AppDataStore
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appData: AppDataStore
    @State private var selectedIcon: String = StringConstants.Image.iconClock
    @State private var selectedColor: String = "color.purple"
    @State private var profileText = ""
    @State private var inputText: String = ""
    @State private var textWidth: CGFloat = 120
    @FocusState private var isTextFieldActive: Bool
    private let colorsArray: [String] = AppColors.all
    var onSave: (CreatedHabit) -> Void
    
    init(isFromCreateArc: Bool = false,habit: Binding<CreatedHabit>, onSave: @escaping (CreatedHabit) -> Void) {
        self._habit = habit
        self.onSave = onSave
        self._tempHabit = State(initialValue: habit.wrappedValue)
    }
    
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
                                let isSelected = icon == tempHabit.icon
                                let width: CGFloat = isSelected ? 50 : 34
                                let height: CGFloat = isSelected ? 50 : 34
                                VStack {
                                    Image(icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .opacity(isSelected ? 1 : 0.40)
                                }
                                .frame(width: width, height: height)
                                .background(Color.white.opacity(0.10))
                                .cornerRadius(width / 2)
                                .background(
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: tempHabit.icon == icon ? 3 : 0)
                                )
                                .id(icon)
                                .onTapGesture {
                                    withAnimation {
                                        tempHabit.icon = icon
                                        proxy.scrollTo(icon, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .task {
                        tempHabit.icon = habit.icon
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo(tempHabit.icon, anchor: .center)
                            }
                        }
                    }
                }
                .frame(height: 50)
                .padding(.vertical, 30)
                HStack {
                    Spacer()
                    ZStack(alignment: .bottom) {
                        // The TextField
                        TextField("Habit Title", text: $tempHabit.title)
                            .font(Font.inter(size: 24, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .tint(.white)
                            .background(
                                // Hidden text to measure width
                                Text(inputText.isEmpty ? " " : inputText)
                                    .font(Font.inter(size: 24, weight: .bold))
                                    .background(GeometryReader { geo in
                                        Color.clear.onAppear {
                                            textWidth = max(120, geo.size.width)
                                        }
                                        .onChange(of: inputText) { _ in
                                            textWidth = max(120, geo.size.width)
                                        }
                                    })
                                    .hidden()
                            )
                        // Underline
                        Rectangle()
                            .frame(width: textWidth, height: 1)
                            .foregroundColor(.white.opacity(0.6))
                            .offset(y: 10)
                    }
                    Spacer()
                }
                .frame(height: 40)
                .padding(.bottom, 25)
                
                HStack(alignment: .top) {
                    TextField("Enter habit’s description", text: $tempHabit.description,  axis: .vertical)
                        .lineLimit(.none)
                        .padding(10)
                        .tint(.white)
                }
                .frame(height: 100, alignment: .topLeading)
                .background(.white.opacity(0.04))
                .cornerRadius(11)
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                
                Spacer()
                
                ShareProgressButton(title: StringConstants.Sheet.addHabit, buttonAction:  {
                    if isFromCreateArc {
                        onSave(tempHabit)
                        dismiss()
                    } else {
                        saveHabit()
                    }
                }, shouldShowArrow: false)
                .padding(.horizontal, 20)
            }
        }
        .frame(height: 400)
    }
    
    // MARK: - Save Arc
    private func saveHabit() {
        let habitID = UUID()
        let newHabit = CreatedHabit(id: habitID, title: tempHabit.title,description: tempHabit.description,icon: tempHabit.icon, color: tempHabit.color)
        dataStore.saveUserCreatedHabit(newHabit)
        if let savedHabitTemplate = dataStore.allHabits.last {
            dataStore.subscribeToHabit(to: savedHabitTemplate) { result in
                switch result {
                case .success(let subscribedHabit):
                    print("✅ Arc created and subscribed: \(subscribedHabit.wrappedTitle)")
                case .failure(let error):
                    print("❌ Failed to subscribe arc: \(error.localizedDescription)")
                }
            }
        }
        dismiss()
    }
}
