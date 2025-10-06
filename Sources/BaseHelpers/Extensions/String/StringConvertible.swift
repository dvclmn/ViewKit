//
//  StringConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

public protocol StringConvertible {
  var toString: String { get }
}

public protocol StyledStringConvertible: StringConvertible {
  func toDisplayString() -> StyledString
}

extension StyledStringConvertible {
  public var toString: String {
    self.toDisplayString().styledString.toString
  }
}

extension String: StyledStringConvertible {
  public func toDisplayString() -> StyledString {
    .init(self)
  }
}

extension Int: StyledStringConvertible {
  public func toDisplayString() -> StyledString {
    .init(self.toString)
  }
}

// MARK: - StringConvertible Conformance
extension Labeled: StyledStringConvertible {

  public func toDisplayString() -> StyledString {
    
    if let styled = self.value {
      "Hello" + styled.styledString
    }
//    .init("\(key)\(separator)\(String(describing: value?.styledString))")

  }
  //  public var stringValue: String {
  //  }
}
