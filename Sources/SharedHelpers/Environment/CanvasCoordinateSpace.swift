//
//  CanvasCoordinateSpace.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI

extension String {
  /// For use with SwiftUI `coordinateSpace()`
  public static var canvasSpace: Self { "canvasSpace" }
}

extension NamedCoordinateSpace {
  public static var canvasSpace: Self { .named(String.canvasSpace) }
}

extension CoordinateSpace {
  public static var canvasSpace: Self { .named(String.canvasSpace) }
}
