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
    
    var backgroundColor: Color {
        switch self {
        case .success: return .green
        case .alert: return .red
        }
    }
    
    var icon: Image {
        switch self {
        case .success: return Image(systemName: "checkmark.circle.fill")
        case .alert: return Image(systemName: "exclamationmark.triangle.fill")
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
                HStack(spacing: 12) {
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(message)
                            .font(.subheadline)
                            .foregroundStyle(type.backgroundColor)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.black.opacity(0.8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .stroke(.appGray, lineWidth: 1)
                        )
                )
                //.shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 16)
                .transition(.asymmetric(
                    insertion: .move(edge: alignmentToEdge(alignment)).combined(with: .opacity),
                    removal: .move(edge: alignmentToEdge(alignment)).combined(with: .opacity)
                ))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 0.3)) {
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

