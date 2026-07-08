//
//  Shape.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/7/2025.
//

import SwiftUI
import VectorKit

extension Shape {

  public static var triangle: Triangle { Triangle() }
  public static var swiftBird: SwiftBird { SwiftBird() }

  /// `let result = shape.analyse(in: rect)`
  public func analyse(in rect: CGRect) -> PathDebugResult {
    self.path(in: rect).analyse(pointSize: .regular)
  }

}
