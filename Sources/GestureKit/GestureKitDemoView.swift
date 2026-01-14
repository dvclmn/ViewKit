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

      //      .onTapGesture { location in
      //        interactionKind = .tap(location)
      //      }

//      .gesture(
//        ExclusiveGesture(
//          TapGesture()
//            .onEnded { location in
//              <#code#>
//            },
//          DragGesture(minimumDistance: 10)
//            .onChanged { value in
//              // Logic for "Y" (The Drag)
//              offset = value.translation
//              interactionKind = .drag(value.toRect(from: value.startLocation, end: .predicted))
//            }
//            .onEnded { _ in
//              interactionKind = .none
//            }
//        )
//      )
    //      .gesture(
    //        DragGesture(minimumDistance: 10)
    //          .exclusively(before: TapGesture())
    //          .onChanged { value in
    //            // Logic for "Y" (The Drag)
    //            offset = value.translation
    //            interactionKind = .drag(value.toRect(from: value.startLocation, end: .predicted))
    //          }
    //          .onEnded { _ in
    //            interactionKind = .none
    //          }
    //      )

  }
}
#if DEBUG
#Preview {
  GestureKitDemoView()
}
#endif
