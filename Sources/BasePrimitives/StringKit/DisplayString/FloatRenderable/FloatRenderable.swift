//
//  DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/7/2025.
//

import SwiftUI

public protocol FloatRenderable: BinaryFloatingPoint, DisplayFragmentRenderable, DisplayPresetRenderable {
  func render(using format: FloatDisplayFormat) -> String
}
public typealias NumberGrouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

extension FloatRenderable {
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    render(using: preset.format)
  }
}

/// This protocol combo is unlikely to exist, but just in case
extension FloatRenderable where Self: PropertiesLabeled {
  public var displayString: String {
    renderProperties(using: .default)
  }
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    renderProperties(using: preset.format)
  }
}

extension Double: FloatRenderable {}
extension CGFloat: FloatRenderable {}
extension Float: FloatRenderable {}

