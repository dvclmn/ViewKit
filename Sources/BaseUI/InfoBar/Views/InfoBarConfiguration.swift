//
//  InfoBarConfiguration.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/8/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var infoBarConfiguration: InfoBarConfiguration = .init()
}

public struct InfoBarConfiguration {
  
  public let barHeight: CGFloat
  /// Space between each individual info item
  public let itemSpacing: CGFloat

  /// Space between an item's label and it's content
  public let labelContentSpacing: CGFloat

  /// Space left at the start/end of the whole InfoBar view
  public let barPaddingH: CGFloat

  public init(
    barHeight: CGFloat = 24,
    itemSpacing: CGFloat = 8,
    labelContentSpacing: CGFloat = 6,
    barPaddingH: CGFloat = 10,
  ) {
    self.barHeight = barHeight
    self.itemSpacing = itemSpacing
    self.labelContentSpacing = labelContentSpacing
    self.barPaddingH = barPaddingH
  }
}
