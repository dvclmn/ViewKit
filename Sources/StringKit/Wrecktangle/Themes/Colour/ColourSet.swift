//
//  ColourSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SwiftUI

extension Box.Theme {

  struct ColourSet: Sendable {
    private var colors: [ColourCategory: Attributes]

    public init(primary: Color, secondary: Color, tertiary: Color, accent: Color) {
      self.colors = [
        .primary: Attributes(foreground: primary),
        .secondary: Attributes(foreground: secondary),
        .tertiary: Attributes(foreground: tertiary),
        .accent: Attributes(foreground: accent),
      ]
    }
  }
}

extension Box.Theme.ColourSet {
  public subscript(category: ColourCategory) -> Box.Theme.Attributes {
    get { colors[category, default: Box.Theme.Attributes(foreground: .primary)] }
    set { colors[category] = newValue }
  }

  /// This method provides an alternative way to retrieve `Attributes` for a given category.
  public func color(for category: ColourCategory) -> Box.Theme.Attributes {
    colors[category, default: Box.Theme.Attributes(foreground: .primary)]
  }

  public mutating func updateColor(
    for category: ColourCategory,
    foreground: Color,
    background: Color? = nil
  ) {
    colors[category]?.foreground = foreground
    colors[category]?.background = background
  }
}
