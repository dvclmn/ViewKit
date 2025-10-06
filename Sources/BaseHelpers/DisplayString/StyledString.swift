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

  public init(_ attributed: AttributedString) {
    self.styledString = attributedString
  }
  public init(_ string: String) {
    self.styledString = string.toAttributedString
  }
  
  
  public init(_ string: String) {
    self.storage = .plain(string)
  }
  
  public init(_ attributed: AttributedString) {
    self.storage = .attributed(attributed)
  }
  
  /// Access as an `AttributedString` (triggers conversion if needed)
  public var styledString: AttributedString {
    switch storage {
      case .plain(let string):
        let attributed = AttributedString(string)
        storage = .attributed(attributed) // mutate to cache conversion
        return attributed
      case .attributed(let attributed):
        return attributed
    }
  }
  
  /// Access as a `String` (cheap for plain, lossily converts otherwise)
  public var plainString: String {
    switch storage {
      case .plain(let string):
        return string
      case .attributed(let attributed):
        return String(attributed.characters)
    }
  }
  
//  public init(_ string: String) {
//    storage = .plain(string)
//  }
//  public init(_ attributed: AttributedString) { storage = .attributed(attributed) }
//
//  public var styledString: AttributedString {
//    switch storage {
//      case .plain(let str): return AttributedString(str)
//      case .attributed(let attr): return attr
//    }
//  }
//
//  public var plainString: String {
//    switch storage {
//      case .plain(let str): return str
//      case .attributed(let attr): return attr.toString
//    }
//  }


}

extension StyledString {

  private var patternPresets: [StyledPattern] {
    [
      StyledPattern(/:\s/, attributes: .highlighter),
      StyledPattern(/\sx\s/, attributes: .neonOrange),
    ]
  }

  //  private var stylePresets: StyledThing {
  //    StyledThing(patterns: patternPresets, sourceText: self.styledString)
  //  }

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
