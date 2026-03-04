//
//  DisplayRenderable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

/// This somewhat joins `FloatRenderable`
/// and `PropertiesLabeled` a bit? I think?
///
/// Except it only exposes a `FloatDisplayPreset`,
/// not the full flexibility of `FloatDisplayFormat`.
///
/// This is meant as a more concise API for quick use in UI etc.
/// Can dip to `FloatRenderable`/`PropertiesLabeled`
/// for more control
public protocol DisplayPresetRenderable: Sendable {
  var displayString: String { get }
  func displayString(_ preset: FloatDisplayPreset) -> String
}

extension DisplayPresetRenderable {
  public var displayString: String {
    displayString(.standard)
  }

  @available(
    *, deprecated, renamed: "displayString(_:)",
    message: "Prefer new FloatDisplayPreset-based method. Use preset .wholeNumber for 0 decimal places."
  )
  public func displayString(places: Int) -> String {
    displayString(.wholeNumber)
  }
}
