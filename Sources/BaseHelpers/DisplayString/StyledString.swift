//
//  StyledString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public struct StyledString {
  public var styledString: AttributedString

  public init(_ attributedString: AttributedString) {
    self.styledString = attributedString
  }
  public init(_ string: String) {
    self.styledString = string.toAttributedString
  }
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
