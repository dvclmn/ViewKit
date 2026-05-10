//
//  StyledText.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import BasePrimitives
import CoreUtilities
import SwiftUI

public enum MatchStrategy {
  case fixed(String)
}

/// Take in
/// - Any arbitrary text
/// - What to look for, to find matches
/// - The style to give matches
public struct StyledText: View {

  let text: String
  let pattern: MatchStrategy
  let styles: AttributeContainer

  public init(
    _ text: String,
    pattern: MatchStrategy,
    styles: AttributeContainer = .highlighter
  ) {
    self.text = text
    self.pattern = pattern
    self.styles = styles
  }
  public var body: some View {
    Text(styled)
  }
}

extension StyledText {

  //  func styled(
  //    attrString: AttributedString,
  //    patternString: String,
  //    attributes: AttributeContainer
  //  ) -> AttributedString {
  //    guard !patternString.isEmpty else { return attrString }
  //    var result = attrString
  //    var searchStart = result.startIndex
  //
  //    while let range = result.range(of: patternString, range: searchStart..<result.endIndex) {
  //      result[range].mergeAttributes(attributes)
  //      // Move start forward to avoid infinite loops on zero-width matches
  //      searchStart = range.upperBound
  //      if searchStart >= result.endIndex { break }
  //    }
  //
  //    return result
  //  }

  private var styled: AttributedString {
    var attrString = AttributedString(text)
    //    let styled = attrString.settingAttributes(styles)
    //    return styled

    let patternString =
      switch pattern {
        case .fixed(let pattern): pattern
      }

    let matches = text.matches(of: patternString)

    //    let ranges = matches.map(\.range)

    for match in matches {
      guard let range = match.range.getAttributedRange(in: attrString) else { break }
      attrString[range].mergeAttributes(styles)
    }
    return attrString
  }

  //  private func match() -> AttributedRange
}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  // @Previewable @State var store = AppHandler()
//  ExampleView()
//  // .environment(store)
//}
//#endif
