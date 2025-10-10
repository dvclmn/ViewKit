//
//  FloatGroupConformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import SwiftUI

extension CGPoint: FloatGroup {

  public var separators: Separators {
    Separators(propertyLabel: ": ", component: ", ")
  }

  public var components: [Component] {
    [
      Component("X", value: self.x),
      Component("Y", value: self.y),
    ]
  }
}

extension CGSize: FloatGroup {
  public var separators: Separators {
    Separators(propertyLabel: ": ", component: " x ")
  }

  public var components: [Component] {
    [
      Component(PropertyLabel("Width", abbreviated: "W"), value: self.width),
      Component(PropertyLabel("Height", abbreviated: "H"), value: self.height),
    ]
  }
}

extension UnitPoint: FloatGroup {
  public var separators: Separators {
    Separators(propertyLabel: ": ", component: ", ")
  }

  public var components: [Component] {
    [
      Component("X", value: self.x),
      Component("Y", value: self.y),
    ]
  }
}

extension CGVector: FloatGroup {
  public var separators: Separators {
    Separators(propertyLabel: ": ", component: " x ")
  }

  public var components: [Component] {
    [
      Component("DX", value: self.dx),
      Component("DY", value: self.dy),
    ]
  }
}
