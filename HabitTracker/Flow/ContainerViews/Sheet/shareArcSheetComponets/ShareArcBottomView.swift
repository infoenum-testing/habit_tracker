//
//  ShareArcBottomView.swift
//  HabitTracker
//
//  Created by ie13 on 30/09/25.
//

import SwiftUI

struct ShareArcBottomView: View {
    
    let saveButtonAction: () -> Void
    let copyButtonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ShareProgressButton(title: "Save", buttonAction : {
                saveButtonAction()
            }, shouldShowArrow: false)
            .padding(.horizontal,65)
            .padding(.bottom, 38)
            .padding(.top, 35)
            Divider()
                .background(Color.gray)
                .padding(.bottom, 27)
            HStack {
                Text("Share the arc")
                    .font(.inter(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.leading, 37)
                Spacer()
            }
            .padding(.bottom, 15)
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.05))
                    .frame(height: 49)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.07), lineWidth: 1) // Proper rounded border
                    )

                HStack {
                    Text("arcetype.com/arc/guthealth")
                        .font(.inter(size: 16, weight: .medium))
                        .lineLimit(1)
                        .padding(.trailing, 5)
                        .foregroundColor(.white.opacity(0.5))

                    Spacer()

                    Button(action: {
                        copyButtonAction()
                        UIPasteboard.general.string = "arcetype.com/arc/guthealth"
                        copyButtonAction()
                    }) {
                        Image(.copyIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal, 14)
            }
            .padding(.horizontal, 37)

        }
    }
}
