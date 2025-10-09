//
//  CreateArcView.swift
//  HabitTracker
//
//  Created by IE14 on 29/09/25.
//

import SwiftUI

struct CreatedArc: Identifiable, Hashable {
    let id : UUID
    var title: String
    var description: String
    var icon: String
    var color: String
    var duration: Int
    var habits: [CreatedHabit]
}



struct CreatedHabit: Identifiable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var icon: String
    var color: String
}

struct CreateArcView: View {
    @State private var habits: [CreatedHabit] = []
    @State private var arcDuration: Int = 15
    @State private var selectedColor: String = ""
    @State private var arcTitle: String = ""
    @State private var textWidth: CGFloat = 120
    @State private var showHabitSheet = false
    @State private var editingHabitIndex: Int? = nil
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    @EnvironmentObject var dataStore: AppDataStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            topSheetIndicator
                .padding(.top,19)
            
            ScrollView(showsIndicators: false) {
                colourPannel
                    .padding(.top,40)
                arcTextField
                    .padding(.horizontal,20)
                    .padding(.vertical,40)
                VStack(spacing: 12) {
                    ForEach(habits.indices, id: \.self) { index in
                        habitCell(for: index)
                            .onTapGesture {
                                editingHabitIndex = index
                                showHabitSheet.toggle()
                            }
                    }
                    addNewHabitButton
                        .padding(.horizontal,20)
                }
                selectArcDuration
                    .padding(.bottom,10)
                    .padding(.horizontal,20)
            }
            ShareProgressButton(
                title: StringConstants.Sheet.createArc,
                buttonAction: saveArc,
                shouldShowArrow: true
            )
            .padding(.horizontal,20)
        }
        .disabled(showToast)
        .background(Color.color_151518.ignoresSafeArea())
        .hideKeyboardOnTap()
        .toast(isShown: $showToast, title: "", message: toastMessage, type: .alert, alignment: .bottom)
        
        .sheet(isPresented: $showHabitSheet) {
            
            CreateHabitView(isFromCreateArc: true,
                            habit: editingHabitIndex != nil
                            ? $habits[editingHabitIndex!]
                            : .constant(CreatedHabit(id: UUID(), title: "", description: "", icon: "circle", color: "color.purple")),
                            onSave: { newHabit in
                if let index = editingHabitIndex {
                    habits[index] = newHabit
                } else {
                    habits.append(newHabit)
                }
            }
            )
            .presentationDetents([.height(400)])
            .presentationCornerRadius(24)
            .presentationBackground {
                Color.color_151518
            }
            .preferredColorScheme(.dark)
            
        }
    }
    
    // MARK: - Private Views
    
    
    private var topSheetIndicator : some View {
        HStack {
            Spacer()
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 119, height: 5)
                .background(.white.opacity(0.2))
                .cornerRadius(15)
            Spacer()
        }
    }
    
    private var colourPannel : some View {
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(AppColors.all, id: \.self) { icon in
                        let isSelected = icon == selectedColor
                        let width: CGFloat = isSelected ? 60 : 40
                        let height: CGFloat = isSelected ? 60 : 40
                        VStack {
                            Circle()
                                .fill(ColorToken.from(string: icon))
                                .frame(width: isSelected ? 36 : 30, height: isSelected ? 36 : 30)
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
        }
        .frame(height: 60)
    }
    
    private var arcTextField: some View {
        HStack {
            Spacer()
            ZStack(alignment: .bottom) {
                // The TextField
                TextField("Arc Title", text: $arcTitle)
                    .font(Font.inter(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .tint(.white)
                    .background(
                        // Hidden text to measure width
                        Text(arcTitle.isEmpty ? " " : arcTitle)
                            .font(Font.inter(size: 24, weight: .bold))
                            .background(GeometryReader { geo in
                                Color.clear.onAppear {
                                    textWidth = max(100, geo.size.width) // minimum 40
                                }
                                .onChange(of: arcTitle) {
                                    textWidth = max(100, geo.size.width)
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
    }
    
    private func habitCell(for index: Int) -> some View {
        HStack(spacing: 5) {
            HStack {
                Image(habits[index].icon)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.white)
            }
            .frame(width: 42, height: 42)
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(habits[index].title)
                    .font(.sfProDisplay(.semibold, size: 14))
                    .foregroundColor(.white)
                Text(habits[index].description)
                    .font(.sfProDisplay(.light, size: 12))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Image("editButton")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.white)
                .frame(width: 42, height: 42)
                .background(Color.white.opacity(0.10))
                .cornerRadius(10)
        }
        .padding(10)
        .frame(height: 60)
        .background(Color.black.opacity(0.6))
        .cornerRadius(14)
    }
    
    // MARK: - Add New Habit Button
    private var addNewHabitButton: some View {
        Button(action: {
            editingHabitIndex = nil
            showHabitSheet.toggle()
        }) {
            HStack(spacing: 10) {
                Image("plusButton")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Add new habit")
                    .font(.sfProDisplay(.semibold, size: 14))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .foregroundColor(.white.opacity(0.7))
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.white.opacity(0.10), lineWidth: 1)
            )
        }
    }
    
    private var arcDurationTitle : some View {
        Text("Arc Duration")
            .font(.inter(size: 18, weight: .medium))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var selectArcDuration : some View {
        
        VStack(spacing: 10) {
            arcDurationTitle
            Menu {
                Button("15 days") { arcDuration = 15 }
                Button("30 days") { arcDuration = 30 }
                Button("45 days") { arcDuration = 45 }
                Button("60 days") { arcDuration = 60 }
                Button("75 days") { arcDuration = 75 }
                Button("90 days") { arcDuration = 90 }
            } label: {
                HStack {
                    Image("calendar")
                        .resizable()
                        .frame(width: 22 , height: 22)
                        .padding(.horizontal, 10)
                    
                    Text("\(arcDuration) days")
                        .font(Font.inter(size: 16, weight: .medium))
                    
                    Spacer()
                    Image("arrowDown")
                        .resizable()
                        .frame(width: 12 , height: 6)
                        .padding(20)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.white.opacity(0.05))
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                )
            }
        }
        .padding(.top, 30)
    }
    
    // MARK: - Save Arc
    private func saveArc() {
        
        if selectedColor.isEmpty {
            toastMessage = "Please select color"
            showToast = true
            return
        }
        
        if arcTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            toastMessage = "Title is required"
            showToast = true
            return
        }
        
        if habits.isEmpty {
            toastMessage = "Please add habit"
            showToast = true
            return
        }
        
        guard !habits.isEmpty else { return }
        let arcID = UUID()
        let newArc = CreatedArc(
            id: arcID,
            title: arcTitle.isEmpty ? "Untitled Arc" : arcTitle,
            description: "User created arc",
            icon: "circle",
            color: selectedColor.isEmpty ? "color.green" : selectedColor,
            duration: arcDuration,
            habits: habits
        )
        dataStore.saveUserCreatedArc(newArc)
        if let savedArcTemplate = dataStore.allArcs.last {
            dataStore.subscribe(to: savedArcTemplate) { result in
                switch result {
                case .success(let subscribedArc):
                    print("✅ Arc created and subscribed: \(subscribedArc.wrappedTitle)")
                case .failure(let error):
                    print("❌ Failed to subscribe arc: \(error.localizedDescription)")
                }
            }
        }
        dismiss()
    }
}

struct CreateArcView_Previews: PreviewProvider {
    static var previews: some View {
        CreateArcView()
    }
}
