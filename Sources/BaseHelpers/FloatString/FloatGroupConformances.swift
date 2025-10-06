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

//extension CGRect: FloatGroup {
//  public var separators: Separators {
//    Separators(propertyLabel: ": ", component: ", ")
//  }
//
//  public var components: [Component] {
//    [
//      Component(PropertyLabel("Si", abbreviated: <#T##String?#>), value: <#T##any FloatDisplay#>)
////      Component("X", value: self.),
////      Component("Y", value: self.y),
//    ]
//  }
//}

//extension CGPoint: FloatDisplay {
//  public var values: [CGFloat] { [x, y] }
//  public var labels: [DisplayString.PropertyLabel] { [.x, .y] }
//}
//
//// But also support more values
//extension CGRect: FloatDisplay {
//  public var values: [CGFloat] { [origin.x, origin.y, size.width, size.height] }
//  public var labels: [DisplayString.PropertyLabel] { [.x, .y, .width, .height] }
//}
//
//extension CGPoint: FloatDisplay {
//  public var valueA: Double { x }
//  public var valueB: Double { y }
//  public var labelA: PropertyLabel { .init("X") }
//  public var labelB: PropertyLabel { .init("Y") }
//}
//
//extension CGSize: FloatDisplay {
//  public var valueA: Double { width }
//  public var valueB: Double { height }
//  public var labelA: PropertyLabel { .init("W", "Width") }
//  public var labelB: PropertyLabel { .init("H", "Height") }
//}
//extension CGVector: FloatDisplay {
//  public var valueA: Double { dx }
//  public var valueB: Double { dy }
//  public var labelA: PropertyLabel { .init("DX") }
//  public var labelB: PropertyLabel { .init("DY") }
//
//}
//extension UnitPoint: FloatDisplay {
//  public var valueA: Double { x }
//  public var valueB: Double { y }
//  public var labelA: PropertyLabel { .init("X") }
//  public var labelB: PropertyLabel { .init("Y") }
//}
