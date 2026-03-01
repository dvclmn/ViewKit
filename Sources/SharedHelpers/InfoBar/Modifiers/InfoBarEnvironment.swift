//
//  HBarEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

//import CoreTools
import EnumMacros
import SwiftUI

extension EnvironmentValues {
  @Entry public var sectionLabelDisplay: LabelDisplay? = nil
  @Entry public var itemLabelDisplay: LabelDisplay? = nil
  @Entry public var isInfoBarPresent: Bool = false
}

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
