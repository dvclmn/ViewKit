//
//  SeperatorKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/3/2026.
//

/// Examples:
///
/// For artwork dimensions, with a `CGSize` of
///
/// "Dimensions" = `label`
/// "W " and "H " = `propertyLabel`
/// " x " = `componentDelimiter`
///
/// ```
/// Dimensions: W 260 x H H410
///
/// ```
/// ## Label Seperator
/// Where `label` is a colon and a space `: `
/// Resulting in `Dimensions: `
///
/// ## Property Label Seperator
/// `propertyLabel` is a space
/// Resulting in `W ` and `H `
///
/// ## Component Delimiter
/// `componentDelimiter` is ` x `
/// Resulting in `{component} x {component}`
public enum SeparatorKind {
  case label
  case propertyLabel
  case componentDelimiter
}

extension SeparatorKind {
  public init(from labelKind: LabelKind) {
    switch labelKind {
      case .main: self = .label
      case .property: self = .propertyLabel
    }
  }

  public var labelKind: LabelKind? { .init(from: self) }
}

//extension SeparatorKind {
//  func separatorString(from separators: Separators) -> String {
//    switch self {
////      case .propertyLabel: labelStyle.separatorString
////      case .componentDelimiter: componentDelimiter.toString ?? ""
//      case .label: sep
//    }
//  }
//
//}
