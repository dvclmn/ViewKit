//
//  HBarEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import BasePrimitives
import EnumMacros
import SwiftUI

@CaseDetection
public enum InfoBarElement {
  case section
  case item
}

extension View {
  public func infoBarStyle(
    for element: InfoBarElement,
    _ display: LabelDisplay
  ) -> some View {
    self.environment(
      element.isSection ? \.sectionLabelDisplay : \.itemLabelDisplay, display
    )
  }
}
