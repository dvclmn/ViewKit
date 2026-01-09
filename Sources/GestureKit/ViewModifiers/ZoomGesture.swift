//
//  ZoomGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

struct ZoomGesture: Gesture {

  @GestureState private var magnification: CGFloat = 1
  @State private var currentZoom: CGFloat?
  @State private var phase: GesturePhase = .none

  let initialZoom: CGFloat?
  let zoomRange: ClosedRange<CGFloat>
  let isEnabled: Bool
  let didUpdateZoom: (ZoomState) -> Void

  init(
    initialZoom: CGFloat? = nil,
    zoomRange: ClosedRange<CGFloat>,
    isEnabled: Bool,
    didUpdateZoom: @escaping (ZoomState) -> Void
  ) {
    self.initialZoom = initialZoom
    self.zoomRange = zoomRange
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
        phase = .changed

        let zoomState = ZoomState(
          zoom: newZoom,
          phase: phase,
        )

        //        zoom = clampedZoom
        didUpdateZoom(zoomState)
        //        didUpdateZoom(.active(magnification: clampedZoom))
      }
      .onEnded { _ in
        phase = .ended
        currentZoom = nil
        didUpdateZoom(.initial)
      }
  }
}
