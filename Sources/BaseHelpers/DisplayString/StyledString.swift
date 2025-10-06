//
//  StyledString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

//public enum StyledStringStorage {
//  case plain(String)
//  case attributed(AttributedString)
//}

public struct StyledString {
  //  private var storage: StyledStringStorage
  public var styledString: AttributedString
  public lazy var plainString: String = { styledString.toString }()

  public init(_ attributed: AttributedString) { styledString = attributed }

  public init(_ string: String) {
    styledString = string.toAttributed
  }
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
    StyledString(lhs.styledString + AttributedString(rhs))
  }

  public static func + (lhs: String, rhs: StyledString) -> StyledString {
    StyledString(AttributedString(lhs) + rhs.styledString)
  }
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
