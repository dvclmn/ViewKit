//
//  Env+Label.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI
import EnumMacros

extension EnvironmentValues {
  
  /// Labels
  @Entry public var labelColour: AnyShapeStyle? = nil
//  @Entry public var itemColour: Color? = nil
  @Entry public var labelWeight: Font.Weight? = nil

  
  /// This is useful because SwiftUI exposes control over display of
  /// icon and label elements in the form of the `LabelStyle` protocol.
  /// So when using custom label styles, setting e.g. `labelStyle(iconOnly)`
  /// will override the custom style. This works around that.
  @Entry public var labelDisplay: LabelDisplay? = nil

  
  /// Icons
  @Entry public var iconColour: AnyShapeStyle? = nil
  @Entry public var iconWeight: Font.Weight? = nil
  @Entry public var iconFontSize: CGFloat? = nil

}

@CaseDetection
public enum LabelDisplay: String, CaseIterable, Identifiable, Equatable, Sendable {
  
  case iconOnly
  case titleOnly
  case titleAndIcon
  case stacked
  case hidden
  
  public var id: String { rawValue }
  
  public var name: String {
    switch self {
      case .iconOnly: "Icon only"
      case .titleOnly: "Title only"
      case .titleAndIcon: "Title & Icon"
      case .stacked: "Stacked"
      case .hidden: "Hidden"
    }
  }
  
  @MainActor
  public func toNative() -> (any LabelStyle)? {
    switch self {
      case .iconOnly: .iconOnly
      case .titleOnly: .titleOnly
      case .titleAndIcon, .stacked: .titleAndIcon
      case .hidden: nil
    }
  }
}
