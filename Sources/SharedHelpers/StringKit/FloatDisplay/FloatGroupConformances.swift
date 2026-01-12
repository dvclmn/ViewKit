//
//  FloatGroupConformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import SwiftUI

extension CGPoint: PropertiesLabeled {
//  public typealias Value = CGFloat
  
//  typealias Value = FloatString
  //  public typealias Component = FloatComponent

//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: ", ")
//  }
  public var separator: String { ", " }
  public var components: [LabelComponent] {
    [
      LabelComponent("X", value: self.x),
      LabelComponent("Y", value: self.y),
    ]
  }
}

extension CGSize: PropertiesLabeled {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: " x ")
//  }
  public var separator: String { ", " }
  public var components: [LabelComponent] {
    [
      LabelComponent(PropertyLabel("Width", abbreviated: "W"), value: self.width),
      LabelComponent(PropertyLabel("Height", abbreviated: "H"), value: self.height),
    ]
  }
}

extension NSRect: PropertiesLabeled {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: " x ")
//  }
  public var separator: String { ", " }
  public var components: [LabelComponent] {
    self.origin.components + self.size.components
//    [
      
//      LabelComponent("Origin", value: self.origin)
//      LabelComponent(PropertyLabel("Width", abbreviated: "W"), value: self.width),
//      LabelComponent(PropertyLabel("Width", abbreviated: "W"), value: self.width),
//      LabelComponent(PropertyLabel("Height", abbreviated: "H"), value: self.height),
//    ]
  }
}


extension UnitPoint: PropertiesLabeled {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: ", ")
//  }
  public var separator: String { ", " }
  public var components: [LabelComponent] {
    [
      LabelComponent("X", value: self.x),
      LabelComponent("Y", value: self.y),
    ]
  }
}

extension CGVector: PropertiesLabeled {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: " x ")
//  }
  public var separator: String { ", " }
  public var components: [LabelComponent] {
    [
      LabelComponent("DX", value: self.dx),
      LabelComponent("DY", value: self.dy),
    ]
  }
}
