//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public enum ComponentSeparator {
  case space
  case none
  case custom(String)
}

public protocol PropertiesLabeled: Sendable {
  //public protocol PropertiesLabeled: FloatRenderable {

  /// E.g. `Width` paired with `10.5`
  ///
  /// Note: ``LabelComponent`` holds onto a ``PropertyLabel``,
  /// which
  /// the ``PropertyLabel`` includes a trailing
  /// separator, delimiting the Label and Value. This is different
  /// to the below ``PropertiesLabeled/separator``.
  var components: [LabelComponent] { get }

  /// Text separating each Label+Value pairing.
  /// E.g. the comma `,` in `X: 10, Y: -20`
  var separator: ComponentSeparator { get }
  //  var separator: String { get }
}

/// Types like `CGPoint` that have float properties.
/// May be a pair, like `CGPoint`'s `x` and `y`,
/// or more, like `CGRect`
extension PropertiesLabeled {

  func renderAll(
    using format: FloatDisplayFormat
  ) -> String {
    let sep = separatorString(using: format)
    return components.map { $0.stringValue(using: format) }
      .joined(sep)
  }

  func separatorString(using format: FloatDisplayFormat) -> String {
    let shouldRender = format.separatorVisibility.contains(.component)
    let str =
      switch separator {
        case .space: " "
        case .none: ""
        case .custom(let str): str
      }
    return shouldRender ? str : ""
  }
  //  func shouldRenderSeparator(using format: FloatDisplayFormat) -> Bool {
  //
  //  }

  /// Some variant of this will be needed, but it shouldn't weirdly
  /// mimic the shape of `FloatRenderable`'s `render`,
  /// because `PropertiesLabeled` isn't just 'one float',
  /// it's a grouping
  //  public func render(using format: FloatDisplayFormat) -> String {
  //    let sepVis = format.separatorVisibility
  //    let labels = components.map { component in
  //
  //      let labelString =
  //        component.label.stringValue(
  //          from: format.labelStyle,
  //          hasSeparator: sepVis.contains(.propertyLabel)
  //        ) ?? ""
  //
  //      let valueString: String = component.value.render(using: format)
  //
  //      return labelString + valueString
  //    }
  //
  //    /// Only include component separator if that option is present
  //    let separatorIfNeeded = sepVis.contains(.component) ? separator : ""
  //    return labels.joined(separatorIfNeeded)
  //  }

}
