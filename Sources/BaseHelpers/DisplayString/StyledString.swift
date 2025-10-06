//
//  StyledString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public struct StyledString {
  public var string: AttributedString

  public init(_ attributedString: AttributedString) {
    self.string = attributedString
  }
  public init(_ string: String) {
    self.string = string.toAttributedString
  }
}

extension StyledString {
  public var stringValue: String { self.string.toString }
}

extension StyledString {

  private var patternPresets: [StyledPattern] {
    [
      StyledPattern(/:\s/, attributes: .highlighter),
      StyledPattern(/\sx\s/, attributes: .neonOrange),
    ]
  }

  private var stylePresets: StyledThing {
    StyledThing(patterns: patternPresets, sourceText: self.string)
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
    var attr = new.string
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
