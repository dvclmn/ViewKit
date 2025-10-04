//
//  FloatGroupConformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

extension CGPoint: FloatGroup {
  public var separators: Separators { .cgPoint }
  public var components: [Component] {
    [
      Component("X", value: self.x),
      Component("Y", value: self.y),
    ]
  }
}
