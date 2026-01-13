//
//  DragGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/8/2025.
//

import SwiftUI

extension DragGesture.Value {
  /// Will return `predictedEndLocation` for the end location,
  /// if `usingPredicated` is true. Otherwise will return `location`
  public func toRect(usingPredicated: Bool = true) -> CGRect {
    CGRect.boundingRect(
      from: startLocation,
      to: usingPredicated ? predictedEndLocation : location
    )
  }
}
