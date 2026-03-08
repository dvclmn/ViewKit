//
//  FloatGroupConformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import SwiftUI

extension CGPoint: PropertiesLabeled {
//  public var defaultSeparator: ComponentDelimiter { .comma }
  public var components: [Labeled] {
//  public var components: [LabelComponent] {
    [
      .init("X", value: x),
      .init("Y", value: y),
    ]
  }
}

extension CGSize: PropertiesLabeled {
  
//  public var defaultSeparator: ComponentDelimiter { .comma }
  public var components: [LabelComponent] {
    [
      .init(PropertyLabel("Width", abbreviated: "W"), value: width),
      .init(PropertyLabel("Height", abbreviated: "H"), value: height),
    ]
  }
}

extension NSRect: PropertiesLabeled {
//  public var defaultSeparator: ComponentDelimiter { .comma }
  public var components: [LabelComponent] { origin.components + size.components }
}

extension UnitPoint: PropertiesLabeled {
//  public var defaultSeparator: ComponentDelimiter { .comma }
  public var components: [LabelComponent] {
    [
      .init("X", value: x),
      .init("Y", value: y),
    ]
  }
}

extension CGVector: PropertiesLabeled {
//  public var defaultSeparator: ComponentDelimiter { .comma }
  public var components: [LabelComponent] {
    [
      .init("DX", value: dx),
      .init("DY", value: dy),
    ]
  }
}
