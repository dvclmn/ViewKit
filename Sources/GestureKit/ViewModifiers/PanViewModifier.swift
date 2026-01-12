//
//  TestPanGestureModifier.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

#if canImport(AppKit)

public typealias PanOutput = (PanGestureStream) -> Void
//public typealias PanOutput = (CGSize, InteractionPhase) -> Void

public struct PanGestureModifier: ViewModifier {

  let isEnabled: Bool
  //  @Binding var panStream: PanGestureStream
  //#warning("Temporarily switched off")
  let panDidChange: PanOutput

  public func body(content: Content) -> some View {
    /// Keeping this as a GeometryReader as layout
    /// gets messed up without it
    //    ZStack {
    content
      .overlay {
        PanGestureView { offset, phase in
          panDidChange(PanGestureStream(offset, phase: phase))
          //          panStream
          //          guard let geometry else { return }
          //          interactions.updateGesture(
          //            .gesturePan(offset),
          //            phase: phase,
          //            modifiers: modifierKeys
          //          )
          //          handler.update(.gesturePan(offset), phase: phase, geometry: geometry)
          //          handler.update(.pan(state), geometry: geometry)
        }
      }
    //      if isEnabled {
    //        PanGestureView { phase in
    ////          action(phase)
    //
    //        }
    //      }
    //    }
  }
}
extension View {
  public func panGesture(
    isEnabled: Bool = true,
    _ panDidChange: @escaping PanOutput
  ) -> some View {
    self.modifier(
      PanGestureModifier(
        isEnabled: isEnabled,
        panDidChange: panDidChange
        //        action: action
      )
    )
  }
}
#endif
