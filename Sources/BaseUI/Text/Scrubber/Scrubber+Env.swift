//
//  Scrubber+Env.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/1/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var isStepperShowing: Bool = true
}

extension View {
  func stepperVisibility(_ isVisible: Bool) -> some View {
    self.environment(\.isStepperShowing, isVisible)
  }
}
