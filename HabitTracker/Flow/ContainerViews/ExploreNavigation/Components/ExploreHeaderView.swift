//
//  ExploreHeaderView.swift
//  HabitTracker
//
//  Created by IE14 on 24/09/25.
//

import SwiftUI

struct ExploreHeaderView: View {
    @State var selectedSegmentSourceType : Int = 0
    @Binding var isArkSelected: Bool
    var body: some View {
        VStack(spacing: 20) {
            Text(StringConstants.ExploreNavigation.explore)
                .font(Font.inter(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .top)
            
            VStack{
                 CustomSegmentedControl(preselectedIndex: $selectedSegmentSourceType,
                                        options: ["Arcs", "Habits"])
            }
            .onChange(of: selectedSegmentSourceType) { _ in
                isArkSelected = selectedSegmentSourceType == 0
            }
        }
    }
}


import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    // this color is coming from theme library
    let color = Color.white

    var body: some View {
        VStack {
            let segmentWidth = 220 / CGFloat(options.count)

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.opacity(0.04))
                    .frame(width:220)

                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                    .frame(width: 104, height: 35) // adjusted for padding
                    .padding(2)
                    .offset(x: CGFloat(preselectedIndex) * segmentWidth)
                    .animation(.interactiveSpring(response: 0.2, dampingFraction: 0.7), value: preselectedIndex)
                // Labels
                HStack(spacing: 0) {
                    ForEach(options.indices, id: \.self) { index in
                        let frame: CGFloat = options[index] == "Arcs" ? 14 : 8

                        HStack {
                            Image(options[index] == "Arcs" ? StringConstants.Image.arcIcon : StringConstants.Image.habitIcon )
                                .resizable()
                                .scaledToFit()
                                .frame(width: frame, height: frame)
                                .foregroundStyle(index == preselectedIndex ? Color.black : Color.white)
                               
                            
                            Text(options[index])
                                .font(Font.sfProDisplay(.semibold, size: 16))
                                .foregroundStyle(index == preselectedIndex ? Color.black : Color.white)
                        }.frame(width:104)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    preselectedIndex = index
                                }
                            }
                            .animation(.easeInOut(duration: 0.0), value: preselectedIndex)
                    }
                }.frame(width:220)
            }
        }
        .frame(height: 40)
    }
}

struct CustomSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedControl(preselectedIndex: .constant(0), options: ["First", "Second", "Third"])
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
