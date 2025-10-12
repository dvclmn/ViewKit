//
//  FloatGroupConformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import SwiftUI

extension CGPoint: PropertiesLabeled {
//  public typealias Component = FloatComponent
  

  public var separators: Separators {
    Separators(propertyLabel: ": ", component: ", ")
  }

  public var components: [LabelComponent] {
    [
      LabelComponent("X", value: self.x),
      LabelComponent("Y", value: self.y),
    ]
  }
}

//extension CGSize: FloatDisplay.Group {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: " x ")
//  }
//
//  public var components: [FloatDisplay.Component] {
//    [
//      FloatDisplay.Component(PropertyLabel("Width", abbreviated: "W"), value: self.width),
//      FloatDisplay.Component(PropertyLabel("Height", abbreviated: "H"), value: self.height),
//    ]
//  }
//}
//
//extension UnitPoint: FloatDisplay.Group {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: ", ")
//  }
//
//  public var components: [FloatDisplay.Component] {
//    [
//      FloatDisplay.Component("X", value: self.x),
//      FloatDisplay.Component("Y", value: self.y),
//    ]
//  }
//}
//
//extension CGVector: FloatDisplay.Group {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: " x ")
//  }
//
//  public var components: [FloatDisplay.Component] {
//    [
//      FloatDisplay.Component("DX", value: self.dx),
//      FloatDisplay.Component("DY", value: self.dy),
//    ]
//  }
//}
