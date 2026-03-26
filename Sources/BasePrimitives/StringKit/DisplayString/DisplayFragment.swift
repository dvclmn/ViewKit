//
//  DisplayElement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public protocol DisplayFragmentRenderable: Sendable {
  func render(using format: FloatDisplayFormat) -> String
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

extension String: DisplayFragmentRenderable {
  public func render(using format: FloatDisplayFormat) -> String { self }
}

/// `DisplayBlock(from: Any?)` can just become `.text(.make(from: value))`
/// `Labeled.init(key:value:Any?)` can become `DisplayFragment.make(from:)`
extension DisplayFragment {
  public static func make(from value: Any) -> DisplayFragment {
    switch value {
      case let result as DisplayFragmentRenderable:
        return DisplayFragment(result)

      case let val as CustomStringConvertible:
        return DisplayFragment(val.description)

      default:
        return DisplayFragment(String(describing: value))
    }
  }
}
