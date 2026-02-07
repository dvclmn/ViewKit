//
//  Env+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension View {
  public func backgroundTint(_ style: AnyShapeStyle?) -> some View {
    self.environment(\.colourOverride, style)
  }

  public func backgroundTint(_ colour: Color?) -> some View {
    self.environment(\.colourOverride, colour?.toShapeStyle)
  }

  public func isDebugMode(_ mode: Bool) -> some View {
    self.environment(\.isDebugMode, mode)
  }
}
