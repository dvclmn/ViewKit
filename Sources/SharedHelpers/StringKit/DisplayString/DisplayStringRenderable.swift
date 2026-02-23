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
public protocol DisplayStringRenderable: Sendable {
  var displayString: String { get }
  func displayString(_ preset: FloatDisplayPreset) -> String
}

extension DisplayStringRenderable {
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

//extension DisplayStringRenderable where Self: FloatRenderable {
//  public func displayString(_ preset: FloatDisplayPreset) -> String {
//    render(using: preset.format)
//  }
//}

//extension DisplayStringRenderable where Self: PropertiesLabeled {
//  public func displayString(_ preset: FloatDisplayPreset) -> String {
//    renderProperties(using: preset.format)
//  }
//}

/// A convenience that just returns the `displayString()`
/// method with it's default values
//public var displayString: String { self.render() }
//public func displayString(_ preset: FloatDisplayPreset) -> String {
//  render(using: preset.format)
//}
//  public var displayStringConcise: String { self.render(using: .short) }

//  public var displayStringWithSign: String {
//    let format = DisplayFormat(
//      decimalPlaces: 2,
//      sign: .always(renderPlusSign: false)
//    )
//    return self.render(using: format)
//  }

/// Going to prefer `render(using:)` for customisation
/// For backwards compat
//  public func displayString(
//    places: Int = 2,
//    grouping: NumberGrouping = .automatic
//  ) -> String {
//    render(
//      using: DisplayFormat(
//        decimalPlaces: places,
//        grouping: grouping,
//      )
//    )
//  }
