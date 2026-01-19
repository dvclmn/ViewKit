//
//  Env+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension View {
  public func backgroundTint(_ style: AnyShapeStyle?) -> some View {
    self.environment(\.explicitColour, style)
  }

  public func backgroundTint(_ colour: Color?) -> some View {
    self.environment(\.explicitColour, colour?.toShapeStyle)
  }

  public func isDebugMode(_ mode: Bool) -> some View {
    #if DEBUG
    self.environment(\.isDebugMode, mode)
    #endif
  }
}
