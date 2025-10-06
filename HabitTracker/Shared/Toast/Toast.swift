//
//  Toast.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 01/09/25.
//

import SwiftUI

enum ToastType {
    case success
    case alert
    
    var borderColor: Color {
        switch self {
        case .success: return Color.brightGreen
        case .alert: return Color.appRed
        }
    }
    
    var icon: Image {
       
        switch self {
        case .success: return Image("checkmark-circle")
        case .alert: return Image("icon.stop")
        }
    }
}

extension View {
    func toast(
        isShown: Binding<Bool>,
        title: String? = nil,
        message: String,
        type: ToastType = .alert,
        alignment: Alignment = .top
    ) -> some View {
        ZStack {
            self
            Toast(isShown: isShown, title: title, message: message, type: type, alignment: alignment)
                .padding(.bottom)
        }
    }
    
    func toastView (
        isShown: Binding<Bool>,
        message: String,
        alignment: Alignment = .top
    ) -> some View {
        ZStack {
            self
            ToastView(isShown: isShown, message: message, alignment: alignment)
                .padding(.bottom)
        }
    }
}

struct Toast: View {
    @Binding var isShown: Bool
    var title: String?
    var message: String
    var type: ToastType
    var alignment: Alignment = .top

    var body: some View {
        VStack {
            if isShown {
                HStack {
                    HStack(spacing: 12) {
                            type.icon
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(type.borderColor)
                        Text(message)
                            .font(Font.sfPro(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 55)
                .background(Color.customBlack)
                .cornerRadius(20)
                .padding(1)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(type.borderColor, lineWidth: 1)
                )
                .padding()
                .transition(.asymmetric(
                    insertion: .move(edge: alignmentToEdge(alignment)).combined(with: .opacity),
                    removal: .move(edge: alignmentToEdge(alignment)).combined(with: .opacity)
                ))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShown = false
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
        .animation(.easeInOut(duration: 0.25), value: isShown)
    }

    private func alignmentToEdge(_ alignment: Alignment) -> Edge {
        switch alignment {
        case .top, .topLeading, .topTrailing: return .top
        case .bottom, .bottomLeading, .bottomTrailing: return .bottom
        default: return .top
        }
    }
}

