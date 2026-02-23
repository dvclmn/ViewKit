//
//  DisplayFormat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation

public struct DisplayFormat {
  public var decimalPlaces: Int
  public var integerLength: Int?
  public var grouping: NumberGrouping
  public var labelStyle: PropertyLabel.Style
  public var separatorVisibility: SeparatorVisibility
  public var sign: SignDisplay

  public init(
    decimalPlaces: Int = 2,
    integerLength: Int? = nil,
    grouping: NumberGrouping = .automatic,
    labelStyle: PropertyLabel.Style = .standard,
    separatorVisibility: SeparatorVisibility = .both,
    sign: SignDisplay = .standard
  ) {
    self.decimalPlaces = decimalPlaces
    self.integerLength = integerLength
    self.grouping = grouping
    self.labelStyle = labelStyle
    self.separatorVisibility = separatorVisibility
    self.sign = sign
  }
}

extension DisplayFormat {
  public func with(integerLength: Int) -> Self {
    var copy = self
    copy.integerLength = integerLength
    return copy
  }
}

// MARK: - Presets
extension DisplayFormat {

  /// 2 decimal places
  public static var `default`: DisplayFormat { .init() }

  public static var short: DisplayFormat {
    .init(
      decimalPlaces: 0,
      grouping: .automatic,
      labelStyle: .abbreviated,
      separatorVisibility: .component
    )
  }

}
