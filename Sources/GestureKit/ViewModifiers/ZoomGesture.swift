//
//  ZoomGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import SwiftUI

struct ZoomGesture: Gesture {

  @GestureState private var magnification: CGFloat = 1
  @State private var currentZoom: CGFloat?
  //  @State private var phase: InteractionPhase = .none

  let initialZoom: CGFloat?
  //  let zoomRange: ClosedRange<CGFloat>
  let isEnabled: Bool
  let didUpdateZoom: ZoomOutput
  //  let didUpdateZoom: (ZoomState) -> Void

  init(
    initialZoom: CGFloat? = nil,
    //    zoomRange: ClosedRange<CGFloat>,
    isEnabled: Bool,
    didUpdateZoom: @escaping ZoomOutput
  ) {
    self.initialZoom = initialZoom
    //    self.zoomRange = zoomRange
    self.isEnabled = isEnabled
    self.didUpdateZoom = didUpdateZoom
  }

  var body: some Gesture {
    MagnifyGesture()
      .updating($magnification) { value, state, _ in
        state = value.magnification
      }
      .onChanged { value in

        if currentZoom == nil {
          currentZoom = initialZoom
        }
        guard let currentZoom else { return }

        let newZoom = (currentZoom) * value.magnification
        //        let clampedZoom = newZoom.clamped(to: zoomRange)
        //        phase = .changed
        didUpdateZoom(ZoomStream(newZoom, phase: .changed))
//        didUpdateZoom(newZoom, .changed)
      }
      .onEnded { _ in
        //        phase = .ended
        currentZoom = nil
        //        didUpdateZoom(.initial)
        didUpdateZoom(ZoomStream(.zero, phase: .ended))
//        didUpdateZoom(.zero, .ended)
      }
  }
}
