//
//  DisplayElement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public protocol DisplayFragmentRenderable: Sendable {
  func render(using format: FloatDisplayFormat) -> String
  //  var displayString: String { get }
  //  func displayString(_ preset: FloatDisplayPreset) -> String
}

/// Type-erased box
public struct DisplayFragment: Sendable {
  private let _render: @Sendable (FloatDisplayFormat) -> String

  public init<R: DisplayFragmentRenderable>(_ base: R) {
    self._render = { format in base.render(using: format) }
  }

  public func render(using format: FloatDisplayFormat) -> String {
    _render(format)
  }
}

extension DisplayFragmentRenderable {

}

extension String: DisplayFragmentRenderable {
  public func render(using format: FloatDisplayFormat) -> String { self }
}

//extension FloatRenderable {
// adapt: FloatRenderable already knows how to render with a FloatDisplayFormat
//}
//extension Double: DisplayFragmentRenderable {
//  public func render(using format: FloatDisplayFormat) -> String {
//    self.render(using: format)  // from FloatRenderable
//  }
//}
// (or just make FloatRenderable refine DisplayFragmentRenderable)

/// `DisplayBlock(from: Any?)` can just become `.text(.make(from: value))`
/// `Labeled.init(key:value:Any?)` can become `DisplayFragment.make(from:)`
extension DisplayFragment {
  public static func make(from value: Any?) -> DisplayFragment {
    switch value {
      case let val as DisplayFragmentRenderable:
        return DisplayFragment(val)

      case let val as CustomStringConvertible:
        return DisplayFragment(val.description)

      case nil:
        return DisplayFragment("nil")

      default:
        return DisplayFragment(String(describing: value))
    }
  }
}
