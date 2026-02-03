//
//  FloatGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

public struct LabelComponent {
  public let label: PropertyLabel
  public let value: any FloatRenderable
  
  public init(
    _ label: PropertyLabel,
    value: any FloatRenderable
  ) {
    self.label = label
    self.value = value
  }
}
