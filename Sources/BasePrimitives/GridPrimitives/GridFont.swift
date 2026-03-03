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
  case ibm = "AcPlus IBM BIOS"
  case ibmEGA = "Ac437 IBM EGA 8x14"
  case geist = "Geist Mono"
  case jetBrains = "JetBrains Mono"

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
      case .ibm: 1.0
      case .ibmEGA: 1.0
      case .geist: 1.0
      case .jetBrains: 1.0
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

}
