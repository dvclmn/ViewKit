//
//  Env+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension View {
  public func backgroundTint<S>(_ tint: S?) -> some View where S: ShapeStyle {
    self.environment(\.explicitColour, tint)
  }

  public func isDebugMode(_ mode: Bool) -> some View {
    self.environment(\.isDebugMode, mode)
  }
}
