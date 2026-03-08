//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled: DisplayFragmentRenderable, DisplayPresetRenderable {

  /// E.g. `Width` paired with `10.5`
  ///
  /// Note: ``LabelComponent`` holds onto a ``PropertyLabel``,
  /// which
  /// the ``PropertyLabel`` includes a trailing
  /// separator, delimiting the Label and Value. This is different
  /// to the below ``PropertiesLabeled/separator``.
  var components: [Labeled] { get }
  //  var components: [LabelComponent] { get }

  func renderProperties(
    using format: FloatDisplayFormat,
    delimiter: ComponentDelimiter
  ) -> String
}

extension PropertiesLabeled {
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    renderProperties(using: preset.format)
  }

  public func render(using format: FloatDisplayFormat) -> String {
    renderProperties(using: format)
  }
}

/// Types like `CGPoint` that have float properties.
/// May be a pair, like `CGPoint`'s `x` and `y`,
/// or more, like `CGRect`
extension PropertiesLabeled {

  public func renderProperties(
    using format: FloatDisplayFormat,
    delimiter: ComponentDelimiter = .comma
  ) -> String {
    return components.map {
      $0.toString(for: .property, using: format) ?? "nil"
    }
    .joined(delimiter.toString ?? "")
  }

}
