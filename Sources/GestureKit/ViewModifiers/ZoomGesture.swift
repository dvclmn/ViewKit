//
//  ZoomGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import SwiftUI

struct ZoomGesture: Gesture {
  @Environment(\.canvasZoomRange) private var zoomRange
  @GestureState private var magnification: CGFloat = 1
  @State private var initialZoom: CGFloat?
  @Binding var zoom: ZoomStream
  
//  let initialZoom: CGFloat?
//  let isEnabled: Bool
//  let didUpdateZoom: ZoomOutput

//  init(
//    initialZoom: CGFloat? = nil,
//    isEnabled: Bool,
////    didUpdateZoom: @escaping ZoomOutput
//  ) {
//    self.initialZoom = initialZoom
//    self.isEnabled = isEnabled
////    self.didUpdateZoom = didUpdateZoom
//  }

  var body: some Gesture {
    MagnifyGesture()
      .updating($magnification) { value, state, _ in
        state = value.magnification
      }
      .onChanged { value in

        if initialZoom == nil {
          initialZoom = zoom.zoom(clampedTo: zoomRange ?? 0...10)
        }
        guard let initialZoom else { return }

        let newZoom = initialZoom * value.magnification
        zoom = ZoomStream(newZoom, phase: .changed)
//        didUpdateZoom(newZoom, .changed)
      }
      .onEnded { value in
        initialZoom = nil
        zoom.phase = .ended
//        zoom = ZoomStream(newZoom, phase: .changed)
//        didUpdateZoom(.zero, .ended)
      }
  }
}
