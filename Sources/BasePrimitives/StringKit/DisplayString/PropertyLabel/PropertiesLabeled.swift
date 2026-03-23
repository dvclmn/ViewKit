//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

/// A type with multiple named float properties, e.g. `CGPoint` (x, y) or `CGSize` (width, height).
///
/// Responsibility: join its `[Labeled]` components with a `ComponentSeparator`.
/// It does not own block-level separator logic — that lives at the `DisplayBlock`/`DisplayString` layer.
public protocol PropertiesLabeled: DisplayFragmentRenderable, DisplayPresetRenderable {

  /// The ordered label+value components, e.g. `[("W", 260), ("H", 410)]` for a `CGSize`.
  var components: [Labeled] { get }

  func renderProperties(
    labelStyle: AbbreviableLabel.Style,
    using format: FloatDisplayFormat,
    delimiter: ComponentSeparator
  ) -> String
}

extension PropertiesLabeled {

  /// Convenience: render with a preset (uses `.standard` label style).
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    renderProperties(labelStyle: .standard, using: preset.format)
  }

  /// `DisplayFragmentRenderable` conformance — renders with default label style.
  public func render(using format: FloatDisplayFormat) -> String {
    renderProperties(labelStyle: .standard, using: format)
  }
}

extension PropertiesLabeled {

  public func renderProperties(
    labelStyle: AbbreviableLabel.Style = .standard,
    using format: FloatDisplayFormat = .default,
    delimiter: ComponentSeparator = .comma
  ) -> String {
    components
      .map { $0.toString(labelStyle: labelStyle, using: format) ?? "" }
      .joined(delimiter.toString ?? "")
  }
}
