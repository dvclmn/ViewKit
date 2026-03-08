//
//  StyledString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

//public struct StyledString {
//  public var styledString: AttributedString
//  public var plainString: String { styledString.toString }
//
//  public init(_ attributed: AttributedString) { styledString = attributed }
//  public init(
//    _ string: String,
//    with attributes: AttributeContainer? = nil
//  ) {
//    if let attributes {
//      styledString = AttributedString(string, attributes: attributes)
//
//    } else {
//      styledString = string.toAttributed
//
//    }
//  }
//}

//extension StyledString {
//
//  private var patternPresets: [StyledPattern] {
//    [
//      StyledPattern(/:\s/, attributes: .highlighter),
//      StyledPattern(/\sx\s/, attributes: .blackOnOrange),
//    ]
//  }
//
//  public func styledAutomatically() -> Self {
//    return patternPresets.reduce(StyledString("")) { partialResult, preset in
//      self.applying { attr in
//
//        fatalError("Need to fix this, since noticing that old typealias RegexMatch makes no sense")
////        attr.editAttributes(matching: preset.pattern) { substring in
////          substring.mergeAttributes(preset.attributes)
////        }
//      }
//    }
//  }
//
//  public func applying(_ modifier: (inout AttributedString) -> Void) -> Self {
//    let new = self
//    var attr = new.styledString
//    modifier(&attr)
//    return new
//  }
//
//  public func italic() -> Self {
//    return self.applying { attr in
//      attr.inlinePresentationIntent = .emphasized
//    }
//  }
//
//  public func bold() -> Self {
//    return self.applying { attr in
//      attr.inlinePresentationIntent = .stronglyEmphasized
//    }
//  }
//
//  public func secondary() -> Self {
//    return self.applying { attr in
//      attr.foregroundColor = .secondary
//    }
//  }
//}

//extension StyledString {
//  public func += (lhs: inout CGPoint, rhs: CGPoint) {
//    lhs = lhs + rhs
//  }
//  public static func += (lhs: inout StyledString, rhs: StyledString) {
//    lhs = lhs + rhs
////    StyledString(lhs.styledString + rhs.styledString)
//  }
//}
//extension StyledString {
//  public static func + (lhs: StyledString, rhs: StyledString) -> StyledString {
//    StyledString(lhs.styledString + rhs.styledString)
//  }
//
//  public static func + (lhs: StyledString, rhs: String) -> StyledString {
//    StyledString(lhs.styledString.appending(rhs))
//  }
//
//  public static func + (lhs: String, rhs: StyledString) -> StyledString {
//    StyledString(lhs.appending(rhs.styledString))
//  }
//
//  public static func + (lhs: StyledString, rhs: AttributedString) -> StyledString {
//    StyledString(lhs.styledString + rhs)
//  }
//
//  public static func + (lhs: AttributedString, rhs: StyledString) -> StyledString {
//    StyledString(lhs + rhs.styledString)
//  }
//}
//
//extension StyledString: ExpressibleByStringLiteral {
//  public init(stringLiteral value: String) {
//    self.init(value)
//  }
//}

//extension Array where Element == StyledString {
//
//  public func joined(_ separator: String = "") -> StyledString {
//    guard !isEmpty else { return StyledString(AttributedString()) }
//
//    /// Pre-create separator once to avoid repeated initialisation
//    let separatorAttr = AttributedString(separator)
//
//    /// Use reduce(into:) for in-place mutation (no copies)
//    return dropFirst().reduce(into: self[0]) { result, element in
//      result = result + separatorAttr + element
//    }
//  }
//}

//extension String {
//  public func bold() -> any StyledStringConvertible {
//    StyledString(self).bold()
//  }
////  public func bold() -> StyledString {
////    StyledString(self).bold()
////  }
//}
//extension String {
//  public func bold() -> StyledString {
//    self.toStyledString.bold()
//  }
//}

//extension StyledString {
//  func splitByNewlines() -> [StyledString] {
//    let string = self.plainString
//    let lines = string.substringLines()
//
//    guard lines.count > 1 else {
//      return [self]
//    }
//
//    var result: [StyledString] = []
//    var currentIndex = self.styledString.startIndex
//
//    for line in lines {
//      let lineLength = line.count
//
//      guard lineLength > 0 else {
//        result.append(StyledString("?", with: .blackOnOrange))
//        continue
//      }
//
//      let endIndex = self.styledString.index(currentIndex, offsetByCharacters: lineLength)
//      let lineAttributed = AttributedString(self.styledString[currentIndex..<endIndex])
//      result.append(StyledString(lineAttributed))
//
//      /// Move past the newline character if there is one
//      if endIndex < self.styledString.endIndex {
//        currentIndex = self.styledString.index(endIndex, offsetByCharacters: 1)
//      }
//    }
//
//    return result
//  }
//}

//extension StyledString: CustomStringConvertible {
//  public var description: String { plainString }
//}
