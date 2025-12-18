//
//  Colour+Attributes.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import SwiftUI

extension Box.Theme {
  /// `Attributes` holds an `AttributeContainer` instance, which
  /// holds all the styles for the set.
  ///
  /// I find `AttributeContainer`s somewhat clumsy to make, so this type
  /// abstracts this job away from the user. Also, `BoxCore` (currently) only
  /// really needs foreground/background colours, so having `AttributeSet`
  /// makes that more accesible/straightforward.
  ///
  /// We can rely on the computed property `container` to return an *actual*
  /// container when we need it.
  struct Attributes: Sendable {
    var foreground: Color
    var background: Color?

    init(foreground: Color, background: Color? = nil) {
      self.foreground = foreground
      self.background = background
    }

    var container: AttributeContainer {
      var attrContainer = AttributeContainer()
      attrContainer.foregroundColor = self.foreground
      attrContainer.backgroundColor = self.background
      return attrContainer
    }
  }
}
