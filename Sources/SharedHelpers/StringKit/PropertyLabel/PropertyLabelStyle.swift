//
//  PropertyLabelStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

import EnumMacros

extension PropertyLabel {
  @CaseDetection
  public enum Style: Equatable, Sendable {
    case none
    case standard(PropertySeparator)
    case abbreviated(PropertySeparator)
    
    public static let standard: Self = .standard(.colon)
    public static let abbreviated: Self = .abbreviated(.colon)
  }
}

extension PropertyLabel.Style {
  
  var separator: PropertySeparator? {
    switch self {
      case .none: nil
      case .standard(let sep): sep
      case .abbreviated(let sep): sep
    }
  }
  
  var separatorString: String {
    separator?.toString ?? ""
  }
}
