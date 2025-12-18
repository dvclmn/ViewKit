//
//  Boolean.swift
//  Collection
//
//  Created by Dave Coleman on 28/10/2024.
//

import SwiftUI

extension Bool {

  public func conditionalColour(
    isTrue trueColour: AnyShapeStyle?,
    otherwise fallback: AnyShapeStyle,
  ) -> AnyShapeStyle {
    self ? (trueColour ?? fallback) : fallback
  }
}
