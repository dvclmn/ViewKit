//
//  SelectionHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import SwiftUI

@Observable
final class SelectionHandler {
  var pointerLocation: CGPoint?
  var zoom: CGFloat = 1
  var pan: CGSize = .zero
  var viewportSize: CGSize?
}

extension SelectionHandler {

  /// Aka Canvas space
  var pointerLocalSpace: CGPoint? {
    guard let pointerLocation,
      let viewportSize
    else { return nil }
    let transform = CoordinateSpaceTransform(
      viewAnchor: .anchoredToCentre,
      zoom: zoom,
      pan: pan,
      viewportSize: viewportSize
    )

    return transform.toLocal(point: pointerLocation)
    //    return CoordinateSpaceTransform.toLocal(
    //      point: pointerLocation,
    //      zoom: zoom,
    //      pan: pan
    //    )
  }
}
