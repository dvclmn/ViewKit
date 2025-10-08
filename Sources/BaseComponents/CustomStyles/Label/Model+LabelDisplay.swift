//
//  File.swift
//
//
//  Created by Dave Coleman on 8/7/2024.
//

import BaseHelpers
import Foundation
import SwiftUI
import CaseDetection

@CaseDetection
public enum LabelDisplay: String, CaseIterable, Identifiable, Equatable, Sendable {

  case iconOnly
  case titleOnly
  case titleAndIcon
  case stacked

  public var id: String { rawValue }

  public var hasIconOnly: Bool {
    self == .iconOnly
  }

  public var name: String {
    switch self {
      case .iconOnly:
        "Icon only"
      case .titleOnly:
        "Title only"
      case .titleAndIcon:
        "Title & Icon"
      case .stacked:
        "Stacked"
    }
  }

    @MainActor
    public func toNative() -> any LabelStyle {
      switch self {
        case .iconOnly: .iconOnly
        case .titleOnly: .titleOnly
        case .titleAndIcon, .stacked: .titleAndIcon
      }
    }
  
//  @MainActor
//  public func toNative() -> any LabelStyle {
//    switch self {
//      case .iconOnly: LabelStyle.iconOnly
//      case .titleOnly: TitleOnlyLabelStyle()
//      case .titleAndIcon, .stacked: TitleAndIconLabelStyle()
//    }
//  }
}
