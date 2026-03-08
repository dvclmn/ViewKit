//
//  PropertySeparator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public struct Separator {
  let separator: String
  let kind: SeparatorKind
  
  public init(
    separator: String,
    kind: SeparatorKind
  ) {
    self.separator = separator
    self.kind = kind
  }
}

public enum SeparatorPreset: Sendable, Equatable {
  case colon
  case custom(String)
  case none
}

extension SeparatorPreset {
  var toString: String? {
    switch self {
      case .colon: ": "
      case .custom(let str): str
      case .none: nil
    }
  }
}

/// Text separating each Label+Value pairing.
/// E.g. the comma `,` in `X: 10, Y: -20`
//public enum PropertySeparator: Sendable, Equatable {
//  case colon
//  case custom(String)
//  case none
//}
//
//extension PropertySeparator {
//  var toString: String? {
//    switch self {
//      case .colon: ": "
//      case .custom(let str): str
//      case .none: nil
//    }
//  }
//}
