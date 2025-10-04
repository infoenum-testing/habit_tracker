//
//  CardView.swift
//  HabitTracker
//
//  Created by ie13 on 30/09/25.
//

import SwiftUI


struct CardView: View {
    let description: String
    let bgColor: Color
    let scale: CGSize
    let isGrid: Bool
    var arc: SubscribedArc
    @Binding var shouldShowAnimation: Bool
    @State private var borderProgress: CGFloat = 0.0
    @State private var showSuccessPopup: Bool = false
    @State private var chnageBGColor: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Text(description)
                    .foregroundColor(.white)
                    .font(.NotCourierSans(size: 10, weight: .bold))
                    .multilineTextAlignment(.center)
                
                if isGrid {
                    VStack {
                        let newWidth = (UIScreen.main.bounds.width - 40)
                        let newHeight = newWidth * (45.0 / 187.0)
                        let color = Color.white
                        GridTileView(itemType: .habit, values: arc.dailyProgressOpacities, selectedColor: color, columnsCount: 15, rowsCount: arc.wrappedDurationDays/15)
                            .frame(height: newHeight)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 8)
                    }
                }
            }
            if showSuccessPopup {
                ZStack {
                    // Blurred background "glow"
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.04)) // darker background for contrast
                        .frame(width: 180, height: 150)
                        .background(
                            VisualEffectBlur(blurStyle: .light)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        )
                        .zIndex(0)
                    
                    // Foreground content (sharp)
                    VStack(spacing: 10) {
                        Image("greenCheckIcon")
                            .resizable()
                            .frame(width: 53, height: 53)
                        
                        Text("Saved to Photos")
                            .font(.inter(size: 12, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 35)
                    .frame(width: 180, height: 150, alignment: .center)
                    .cornerRadius(20)
                    .zIndex(1)
                }
                .frame(width: 180, height: 150, alignment: .center)
                
            }
        }
        .frame(width: 280, height: 350)
        .background(chnageBGColor ? Color.appCyan.opacity(0.08) : bgColor)
        .cornerRadius(25)
        .shadow(radius: 10)
        .scaleEffect(scale)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .inset(by: 0.5)
                .stroke(.white.opacity(0.16))
                .scaleEffect(scale)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .trim(from: 0, to: borderProgress)
                .stroke(Color.appCyan, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 350, height: 280)
                .rotationEffect(.degrees(-90))
        )
        .onChange(of: shouldShowAnimation) { _, newValue in
            if newValue {
                chnageBGColor = true
                // Animate border once
                withAnimation(.linear(duration: 3.0)) {
                    borderProgress = 1.0
                    shouldShowAnimation = false
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                    showSuccessPopup = true
                }
            }
        }
    }
}


// Helper for UIKit blur
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

extension CardView {
    func clearForExport() -> some View {
        ZStack {
            VStack(spacing: 8) {
                Text(description)
                    .foregroundColor(.white)
                    .font(.NotCourierSans(size: 10, weight: .bold))
                    .multilineTextAlignment(.center)
                
                if isGrid {
                    let newWidth = (UIScreen.main.bounds.width - 40)
                    let newHeight = newWidth * (45.0 / 187.0)
                    let color = Color.white
                    GridTileView(itemType: .habit, values: arc.dailyProgressOpacities, selectedColor: color,columnsCount: 15, rowsCount: 4)
                        .frame(height: newHeight)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 8)
                }
            }
        }
        .frame(width: 280, height: 350)
    }
}
