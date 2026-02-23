//
//  DisplayElement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public protocol DisplayAtomRenderable: Sendable {
  func render(using format: FloatDisplayFormat) -> String
  //  var displayString: String { get }
  //  func displayString(_ preset: FloatDisplayPreset) -> String
}

/// Type-erased box
public struct DisplayAtom: Sendable {
  private let _render: @Sendable (FloatDisplayFormat) -> String

  public init<R: DisplayAtomRenderable>(_ base: R) {
    self._render = { format in base.render(using: format) }
  }

  public func render(using format: FloatDisplayFormat) -> String {
    _render(format)
  }
}

extension DisplayAtomRenderable {

}

extension String: DisplayAtomRenderable {
  public func render(using format: FloatDisplayFormat) -> String { self }
}

//extension FloatRenderable {
// adapt: FloatRenderable already knows how to render with a FloatDisplayFormat
//}
//extension Double: DisplayAtomRenderable {
//  public func render(using format: FloatDisplayFormat) -> String {
//    self.render(using: format)  // from FloatRenderable
//  }
//}
// (or just make FloatRenderable refine DisplayAtomRenderable)

/// `DisplayBlock(from: Any?)` can just become `.text(.make(from: value))`
/// `Labeled.init(key:value:Any?)` can become `DisplayAtom.make(from:)`
extension DisplayAtom {
  public static func make(from value: Any?) -> DisplayAtom {
    switch value {
      case let v as DisplayAtomRenderable:
        return DisplayAtom(v)

      case let v as CustomStringConvertible:
        return DisplayAtom(v.description)

      case nil:
        return DisplayAtom("nil")

      default:
        return DisplayAtom(String(describing: value))
    }
  }
}
