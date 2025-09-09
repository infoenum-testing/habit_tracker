//
//  ShareProgressButton.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 08/09/25.
//

import SwiftUI

struct ShareProgressButton: View {
    var height: CGFloat = 60
    var imageName: String?
    var title: String
    var buttonAction: () -> Void
    var shouldShowArrow: Bool = true
        
    var body: some View {
        Button(action: {
            buttonAction()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color(white: 0.85))
                    .frame(height: height)
                    .offset(y: 6)

                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.white)
                    .frame(height: height)
                HStack(alignment: .center,spacing: 5) {
                    if let imageName = imageName {
                        Image(imageName)
                    }
                    Text(title)
                        .font(Font.sfPro(size: 20, weight: .medium))
                    if shouldShowArrow {
                        Image(StringConstants.Image.arrowRight)
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
                .foregroundColor(.black)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ShareProgressButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ShareProgressButton(imageName: "shareIcon", title: "Share Progress" ,buttonAction: {
                // handle share action
            })
        }
    }
}



