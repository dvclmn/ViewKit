//
//  String+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

extension String {

  public var toURL: URL? {
    return URL(string: self)
  }

  public var toAttributed: AttributedString {
    return AttributedString(self)
  }

  public var toMarkdownCompatible: LocalizedStringKey {
    LocalizedStringKey(self)
  }

  public var toDescribing: String {
    return String(describing: self)
  }

  public var toCharacters: [Character] { Array(self) }

  public var camelCaseToSnakeCase: String {
    var result = ""
    for (index, ch) in self.enumerated() {
      if ch.isUppercase {
        if index > 0 { result.append("_") }
        result.append(ch.lowercased())
      } else {
        result.append(ch)
      }
    }
    return result
  }
  
  public var camelCaseToWords: String {
    /// Handle both upper camel case (PatternType) and lower camel case (patternType)
    let pattern = "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])"
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: self.count)
    
    let spaced = regex?
      .stringByReplacingMatches(in: self, options: [], range: range, withTemplate: " ")
      .capitalized ?? self
    
    return spaced
  }

}
