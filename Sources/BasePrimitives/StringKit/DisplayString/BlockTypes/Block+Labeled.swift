//
//  Model+Labeled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

/// A label+value pair. Used both as a standalone `DisplayBlock` (e.g. `"Dimensions: 260 x 410"`)
/// and as an individual component inside `PropertiesLabeled` (e.g. `"W 260"`).
///
/// Separator ownership:
/// - The separator between this label and its value (`separator`, default `" "`) lives here.
/// - The separator between a top-level block label and its content (e.g. `": "`) is supplied
///   by the `DisplayBlock` rendering layer.
/// - The delimiter between sibling components (e.g. `" x "`) lives on `PropertiesLabeled`.
public struct Labeled: Sendable {

  public let key: AbbreviableLabel
  public let value: DisplayFragment?

  /// Separator between the label text and the value,
  /// e.g. the space in `W 260`. Defaults to `" "`.
  public let separator: ComponentSeparator

  /// Per-item float format override. Inherits from context when `nil`.
  public let formatOverride: FloatDisplayFormat?

  public init(
    key: AbbreviableLabel,
    value: DisplayFragment?,
    separator: ComponentSeparator = .colon,
    //    separator: String?,
    formatOverride: FloatDisplayFormat? = nil
  ) {
    self.key = key
    self.separator = separator
    self.value = value
    self.formatOverride = formatOverride
  }
}

// MARK: - Convenience initialisers

extension Labeled {

  /// General-purpose init: key string + any value.
  public init(
    _ key: String,
    value: Any?,
    separator: ComponentSeparator = .colon,
    format: FloatDisplayFormat? = nil
  ) {
    self.init(
      key: AbbreviableLabel(key),
      value: value.map { DisplayFragment.make(from: $0) },
      separator: separator,
      formatOverride: format
    )
  }

  /// Convenience for Collection types
  public init<C: Collection>(
    _ key: String,
    data: C,
    maxItems: Int? = nil,
    showCount: Bool = true,
    separator: ComponentSeparator = .colon,
  ) {
    self.init(
      key: AbbreviableLabel(key),
      value: .make(from: data),
      separator: separator,
    )
  }

  /// Convenience init for `PropertiesLabeled` components — takes a `FloatRenderable` value directly.
  public init(
    _ label: String,
    abbreviated: String? = nil,
    value: any FloatRenderable
  ) {
    self.init(
      key: AbbreviableLabel(label, abbreviated: abbreviated),
      value: DisplayFragment(value),
      separator: .space,
      formatOverride: nil
    )
  }
}

// MARK: - Rendering

extension Labeled {

  public var block: DisplayBlock { .labeled(self) }

  /// Renders the label text only (no value or separator).
  public func labelPart(with style: AbbreviableLabel.Style = .standard) -> String? {
    key.labelText(with: style)
  }

  /// Renders the value only.
  public func valuePart(using format: FloatDisplayFormat = .default) -> String? {
    let effectiveFormat = formatOverride ?? format
    return value?.render(using: effectiveFormat)
  }

  /// Renders `"<label><separator><value>"`, e.g. `"W 260"`.
  /// Pass `.none` for `labelStyle` to suppress the label entirely.
  /// Returns `nil` if all parts are absent.
  public func toString(
    labelStyle: AbbreviableLabel.Style = .standard,
    using format: FloatDisplayFormat = .default
  ) -> String? {
    let effectiveFormat = formatOverride ?? format
    let label: String? = labelPart(with: labelStyle)
    let separatorString: String? = label != nil ? separator.toString : nil
    let value: String? = valuePart(using: effectiveFormat)

    let result = [label, separatorString, value].compactMap { $0 }.joined()
    return result.isEmpty ? nil : result
  }
}
