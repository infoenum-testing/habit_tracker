//
//  ShareArcSheet.swift
//  HabitTracker
//
//  Created by ie13 on 29/09/25.
//

import SwiftUI
import Photos

struct ShareArcSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCard: Int = 0 // Track selected card
    @State private var showBorderAnimation: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.homeSheetBackground.ignoresSafeArea(.all)
            
            VStack(spacing: 0){
                Capsule()
                    .foregroundColor(.clear)
                    .frame(width: 90, height: 5)
                    .background(.white.opacity(0.11))
                    .cornerRadius(3)
                    .padding(.top, 12)
                
                ScrollView(showsIndicators: false) {
                    // CardSwitcherView now binds selectedCard
                    CardSwitcherView(selectedCard: $selectedCard, showBorderAnimation: $showBorderAnimation)
                    
                    ShareArcBottomView(saveButtonAction: {
                        showBorderAnimation = true
                        saveSelectedCardTransparent()
                    })
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.homeSheetBackground)
        }
    }
    
    private func saveSelectedCardTransparent() {
        let renderer = ImageRenderer(content: getSelectedCardView())
        renderer.isOpaque = false
        renderer.scale = UIScreen.main.scale
        
        if let uiImage = renderer.uiImage {
            // Must export as PNG to preserve transparency
            if let pngData = uiImage.pngData() {
                PHPhotoLibrary.shared().performChanges({
                    let options = PHAssetResourceCreationOptions()
                    let creationRequest = PHAssetCreationRequest.forAsset()
                    creationRequest.addResource(with: .photo, data: pngData, options: options)
                }) { success, error in
                    if success {
                        print("✅ Saved with transparency")
                        // dissmiss after 4.0 sec 3.0 animation of cell saveing image + 1.0 sec
                        DispatchQueue.main.asyncAfter(deadline: .now()+4.0) {
                            dismiss ()
                        }
                    } else if let error = error {
                        print("❌ Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    func getSelectedCardView() -> some View {
        let cardData = CardSwitcherView(selectedCard: $selectedCard, showBorderAnimation: $showBorderAnimation).array[selectedCard]
        let des = cardData["des"] as? String ?? ""
        let isGrid = cardData["isGrid"] as? Bool ?? false
        return CardView(
            description: des,
            bgColor: .clear,
            scale: CGSize(width: 0.93, height: 0.93),
            isGrid: isGrid,
            shouldShowAnimation: .constant(false)
        ).clearForExport()
    }
}
