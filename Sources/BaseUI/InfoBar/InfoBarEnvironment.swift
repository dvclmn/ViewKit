//
//  HBarEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import SwiftUI
import CoreTools

extension EnvironmentValues {
  @Entry public var sectionLabelDisplay: LabelDisplay? = nil
  @Entry public var itemLabelDisplay: LabelDisplay? = nil
}

public enum InfoBarElement {
  case section
  case item
  
  var isSection: Bool {
    self == .section
  }
}

extension View {
  public func infoBarStyle(
//  public func setInfoBarLabelDisplay(
    for element: InfoBarElement,
    _ display: LabelDisplay
  ) -> some View {
//    self.environment(\.sectionLabelDisplay, display)
    self.environment(element.isSection ? \.sectionLabelDisplay : \.itemLabelDisplay, display)
  }
}
