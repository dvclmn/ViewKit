//
//  GestureKitDemoView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

struct GestureKitDemoView: View {

  @State private var interactionKind: PointerInteraction = .none
  @State private var offset = CGSize.zero

  var body: some View {

    Text("Hello")
      .padding(40)
      .frame(width: 600, height: 700)
      .background(.black.opacity(0.6))

      .debugTextOverlay("Interaction: ", interactionKind.referenceName)
    
      .onTapGesture { location in
        interactionKind = .tap(location)
      }
      .gesture(
        DragGesture(minimumDistance: 10) // Distinguishes from tap
          .onChanged { value in
            // Logic for "Y" (The Drag)
            offset = value.translation
            interactionKind = .drag(value.)
          }
          .onEnded { _ in
            // Reset or finalize drag logic
            withAnimation(.spring()) {
              offset = .zero
            }
            message = "Drag Ended"
          }
      )

  }
}
#if DEBUG
#Preview {
  GestureKitDemoView()
}
#endif
