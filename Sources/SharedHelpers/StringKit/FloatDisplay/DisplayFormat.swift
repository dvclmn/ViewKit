//
//  DisplayFormat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation

public struct DisplayFormat {
  public var decimalPlaces: Int
  public var grouping: NumberGrouping
  public var labelStyle: PropertyLabel.Style
  public var separatorVisibility: SeparatorVisibility
  
  public init(
    decimalPlaces: Int = 2,
    grouping: NumberGrouping = .automatic,
    labelStyle: PropertyLabel.Style = .standard,
    separatorVisibility: SeparatorVisibility = .both
  ) {
    self.decimalPlaces = decimalPlaces
    self.grouping = grouping
    self.labelStyle = labelStyle
    self.separatorVisibility = separatorVisibility
  }
}

extension DisplayFormat {
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
