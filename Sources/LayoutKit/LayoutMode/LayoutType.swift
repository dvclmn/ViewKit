//
//  LayoutType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI
import CoreTools

/// This is here and not `SharedHelpers` because it relies on `LayoutKit`
extension EnvironmentValues {
  @Entry public var layoutType: LayoutType = .passthrough
}

@CaseDetection
public enum LayoutType {
  case hstack(alignment: VerticalAlignment = .center)
  case vstack(alignment: HorizontalAlignment = .center)
  case grid(alignment: Alignment = .center, horizontalSpacing: CGFloat? = nil)
  case passthrough

  /// Defaults to ``LayoutType/passthrough`` if axis is nil
  /// Note: this doesn't afford a chance to pass in desired
  /// alignment. May fix this in future.
  public init(fromAxis axis: Axis?) {
    switch axis {
      case .horizontal: self = .hstack()
      case .vertical: self = .vstack()
      case nil: self = .passthrough
    }
  }

  /// Creates a concrete Layout based on `LayoutType`.
  /// - Parameter spacing: For `hstack` & `vstack`, this is supplied to their
  /// `spacing` parameter. For `grid`, this is supplied to `verticalSpacing`.
  /// Grid's `horizontalSpacing` is handled in the associated value
  /// - Returns: A layout usable in a SwiftUI view. Returns nil if self is `passthrough`
  public func toLayout(
    spacing: CGFloat? = nil
  ) -> AnyLayout? {
    switch self {
      case .hstack(let alignment):
        AnyLayout(
          HStackLayout(
            alignment: alignment,
            spacing: spacing
          )
        )
      case .vstack(let alignment):
        AnyLayout(
          VStackLayout(
            alignment: alignment,
            spacing: spacing
          )
        )
      case .grid(let alignment, let spacingH):
        AnyLayout(
          GridLayout(
            alignment: alignment,
            horizontalSpacing: spacingH,
            verticalSpacing: spacing
          )
        )

      case .passthrough: nil
    }
  }
}
