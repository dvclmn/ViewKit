//
//  StyledString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public struct StyledString {
  public var styledString: AttributedString
  public var plainString: String { styledString.toString }

  public init(_ attributed: AttributedString) { styledString = attributed }
  public init(_ string: String) { styledString = string.toAttributed }
}

extension StyledString {

  private var patternPresets: [StyledPattern] {
    [
      StyledPattern(/:\s/, attributes: .highlighter),
      StyledPattern(/\sx\s/, attributes: .neonOrange),
    ]
  }

  public func styledAutomatically() -> Self {
    return patternPresets.reduce(StyledString("")) { partialResult, preset in
      self.applying { attr in

        attr.editAttributes(matching: preset.pattern) { substring in
          substring.mergeAttributes(preset.attributes)
        }
      }
    }
  }

  public func applying(_ modifier: (inout AttributedString) -> Void) -> Self {
    let new = self
    var attr = new.styledString
    modifier(&attr)
    return new
  }

  public func italic() -> Self {
    return self.applying { attr in
      attr.inlinePresentationIntent = .emphasized
    }
  }

  public func bold() -> Self {
    return self.applying { attr in
      attr.inlinePresentationIntent = .stronglyEmphasized
    }
  }

  public func secondary() -> Self {
    return self.applying { attr in
      attr.foregroundColor = .secondary
    }
  }
}

extension StyledString {
  public static func + (lhs: StyledString, rhs: StyledString) -> StyledString {
    StyledString(lhs.styledString + rhs.styledString)
  }

  public static func + (lhs: StyledString, rhs: String) -> StyledString {
    StyledString(lhs.styledString.appending(rhs))
  }

  public static func + (lhs: String, rhs: StyledString) -> StyledString {
    StyledString(lhs.appending(rhs.styledString))
  }
  
  public static func + (lhs: StyledString, rhs: AttributedString) -> StyledString {
    StyledString(lhs.styledString + rhs)
  }
  
  public static func + (lhs: AttributedString, rhs: StyledString) -> StyledString {
    StyledString(lhs + rhs.styledString)
  }
}

extension StyledString: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension Array where Element == StyledString {

  public func joined(_ separator: String = "") -> StyledString {
    guard !isEmpty else { return StyledString(AttributedString()) }

    /// Pre-create separator once to avoid repeated initialisation
    let separatorAttr = AttributedString(separator)

    /// Use reduce(into:) for in-place mutation (no copies)
    return dropFirst().reduce(into: self[0]) { result, element in
      result = result + separatorAttr + element
//      result.append(separatorAttr)
//      result.append(element)
    }
  }
}

extension StyledString {
//  public func appending(_ other: StyledString) -> StyledString {
//    return .init(attributed)
//  }
//
//  public func appending(_ attributed: AttributedString) -> StyledString {
//    return .init(attributed)
//  }
//
//  public func appending(_ attributed: AttributedString) -> StyledString {
//    return .init(attributed)
//  }

  //  public func append(_ other: StyledString) -> Self {
  //    self + other
  //  }
  //
  //  public func append(_ attributed: AttributedString) -> Self {
  //    self + attributed
  //  }
}

//extension StyledString: StyledStringConvertible {
//  public func toDisplayString() -> StyledString {
//    let valuePart = value?.styledString ?? ""
//    return StyledString("\(key)\(separator)\(valuePart)")
//  }
//}

extension String {
  public func bold() -> StyledString {
    StyledString(self).bold()
    //    StyledString(self).bold()
  }
}
