//
//  GridFont.swift
//  SwiftBox
//
//  Created by Dave Coleman on 29/8/2024.
//

import SwiftUI

/// Note: Have removed use of QuickLabel so GridFont can be moved to BasePrimitives
public enum GridFont: String, Sendable, Codable, Hashable, Equatable, CaseIterable, Identifiable {

  case menlo = "Menlo"
  case sfMono = "SF Mono"
  case courier = "Courier New"
  case monaco = "Monaco"
  case terminal = "BigBlueTerm437 Nerd Font"
  //  case geist = "Geist Mono"
  //  case jetBrains = "JetBrains Mono"

  public var id: String { rawValue }
  public var name: String { rawValue }
}

extension GridFont {

  /// Some fonts naturally appear larger or smaller than a baseline of SF Mono
  public var perceptualScale: CGFloat {
    switch self {
      case .menlo: 1.0
      case .sfMono: 1.0
      case .courier: 1.0
      case .monaco: 1.0
      case .terminal: 1.0
    //      case .geist: 1.0
    //      case .jetBrains: 1.0
    }
  }

  public func fontSizeScaled(_ size: CGFloat) -> CGFloat {
    /// Convention: perceptualScale expresses how large this font
    /// appears relative to the SF Mono baseline.
    ///   - `1.0` –> matches baseline
    ///   - `> 1` –> appears larger than baseline (so we scale size down)
    ///   - `< 1` –> appears smaller than baseline (so we scale size up)
    /// To harmonize visual size across fonts, divide by perceptualScale.
    let scale = perceptualScale
    guard scale != 0 else { return size }
    return size / scale
  }

  /// A horizontal offset to be applied in sertain contexts, to
  /// counteract font metrics something something
  ///
  /// Aka `BigBlueTerm437` has a slight bias to the left,
  /// so needs a nudge to the right to appear perfectly centred
  /// in its own advance width
  ///
  /// Applied as a factor of its current width.
  /// E.g. `width * horizontalOffsetFactor`
  public var horizontalOffsetFactor: CGFloat? {
    switch self {
      case .menlo: nil
      case .sfMono: nil
      case .courier: nil
      case .monaco: nil
      case .terminal: 0.14
    }
  }

}
// MARK: - Bundled
extension GridFont {
  public var bundledFont: BundledFont? {
    switch self {
      case .terminal: .bigBlueTerm
      default: nil
    }
  }

  public func resolvedFont(size: CGFloat) -> Font {
    switch self {
      case .sfMono:
        return .system(size: size, design: .monospaced)

      default:
        guard let bundledFont else {
          return .custom(rawValue, fixedSize: size)
        }
        return bundledFont.swiftUIFont(size: size)
    }
  }
}
