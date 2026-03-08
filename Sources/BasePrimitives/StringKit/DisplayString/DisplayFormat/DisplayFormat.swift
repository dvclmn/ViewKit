//
//  FloatDisplayFormat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation

/// For now this can be used both for single Float values,
/// as well as multiple together. As often a grouping of floats
/// looks best sharing the same overall formatting.
public struct FloatDisplayFormat: Equatable, Sendable {
  public var decimalPlaces: Int
  public var integerLength: Int?
  public var grouping: NumberGrouping
  public var labelStyle: PropertyLabel.Style
  public var separators: Separators
  //    public var propertySeparator: PropertySeparator
  //  public var componentDelimiter: ComponentDelimiter
  //  public var separatorVisibility: SeparatorVisibility
  public var sign: SignDisplay

  public init(
    decimalPlaces: Int = 2,
    integerLength: Int? = nil,
    grouping: NumberGrouping = .automatic,
    labelStyle: PropertyLabel.Style = .standard,
    separators: Separators = .default,
    //    propertySeparator: PropertySeparator = .colon,
    //    componentDelimiter: ComponentDelimiter = .comma,
    //    separatorVisibility: SeparatorVisibility = .both,
    sign: SignDisplay = .standard
  ) {
    self.decimalPlaces = decimalPlaces
    self.integerLength = integerLength
    self.grouping = grouping
    self.labelStyle = labelStyle
    self.separators = separators
    //    self.propertySeparator = propertySeparator
    //    self.componentDelimiter = componentDelimiter
    //    self.separatorVisibility = separatorVisibility
    self.sign = sign
  }
}

extension FloatDisplayFormat {
  public static func fromPreset(preset: FloatDisplayPreset) -> Self {
    preset.format
  }
  //  public init(fromPreset preset: FloatDisplayPreset) {
  //    self = preset.format
  //  }

  func separatorString(for kind: SeparatorKind) -> String {
    separators[kind: kind] ?? ""
  }

  public func with(integerLength: Int) -> Self {
    var copy = self
    copy.integerLength = integerLength
    return copy
  }

  public static var `default`: Self { .init() }
}

extension BinaryFloatingPoint {
  public func toPercentString(
    within range: ClosedRange<Self>,
    decimalPlaces: Int = 0
  ) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.render(using: .init(decimalPlaces: decimalPlaces)) + "%")
  }
}
