//
//  GridFont.swift
//  SwiftBox
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation
import CoreTools

public enum GridFont: String, ModelBase, Pickable, CaseIterable, Identifiable {

  public static let pickerLabel: QuickLabel = "Font"
  
  case menlo = "Menlo"
  case sfMono = "SF Mono"
  case courier = "Courier New"
  case monaco = "Monaco"
  case ibm = "AcPlus IBM BIOS"
  case geist = "Geist Mono"
  case jetBrains = "JetBrains Mono"

  public var id: String { rawValue }

  public var name: String { rawValue }
  public var label: QuickLabel { QuickLabel(name) }
  
  public static let baseFontSize: CGFloat = 15

  /// Provides effective aspect ratio, to calculate unit size
  public var baseSize: CGSize {
    switch self {
      case .menlo: CGSize(9.04, 18)
      case .sfMono: CGSize(9.27, 18)
      case .courier: CGSize(9, 16.95)
      case .monaco: CGSize(9, 19)
      case .ibm: CGSize(12.48, 15.65)
      case .geist: CGSize(12.48, 15.65)
      case .jetBrains: CGSize(12.48, 15.65)
    }
  }
}

