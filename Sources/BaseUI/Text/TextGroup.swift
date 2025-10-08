//
//  TextGroup.swift
//  Components
//
//  Created by Dave Coleman on 6/11/2024.
//


import SwiftUI
import SharedHelpers

@MainActor
@resultBuilder
public struct TextBuilder {

  // Accepts array elements from each child expression
  public static func buildBlock(_ components: [Text]...) -> [Text] {
    components.flatMap { $0 }
  }
  
  public static func buildOptional(_ component: [Text]?) -> [Text] {
    component ?? []
  }
  
  public static func buildEither(first component: [Text]) -> [Text] {
    component
  }
  
  public static func buildEither(second component: [Text]) -> [Text] {
    component
  }
  
  public static func buildArray(_ components: [[Text]]) -> [Text] {
    components.flatMap { $0 }
  }
  
  // Allow a single Text literal to be treated as an array of one
  public static func buildExpression(_ expression: Text) -> [Text] {
    [expression]
  }
  
//  public static func buildBlock(_ components: Text...) -> [Text] {
//    components
//  }
//
//  public static func buildOptional(_ component: [Text]?) -> [Text] {
//    component ?? []
//  }
//
//  public static func buildEither(first component: [Text]) -> [Text] {
//    component
//  }
//
//  public static func buildEither(second component: [Text]) -> [Text] {
//    component
//  }
//
//  public static func buildArray(_ components: [[Text]]) -> [Text] {
//    components.flatMap { $0 }
//  }
}

public struct TextGroup: View {

  let content: Text

  public init(
    separator: String = "\n",
    @TextBuilder content: () -> [Text]
  ) {
    self.init(separator: Text(separator), content: content)
  }

  public init(
    separator: Text,
    @TextBuilder content: () -> [Text]
  ) {
    self.content = content().joined(separator: separator)
  }

  public var body: some View {
    content
  }
}

//extension Array where Element == Text {
//  func combined(_ separator: String = "\n") -> Text {
//    self.enumerated().reduce(Text("")) { result, item in
//      let (index, text) = item
//      guard index == 0 else {
//        return result + Text(separator) + text
//      }
//      return text
//    }
//  }
//}

extension Array where Element == Text {
  func joined(separator: Text) -> Text {
    guard let first = first else { return Text("") }
    return dropFirst().reduce(first) { $0 + separator + $1 }
  }
}

struct TextGroupExample: View {

  var body: some View {
    
    VStack {
      TextGroup(separator: Text(" • ")) {
        Text("Hello")
        
        switch (true, false) {
          case (true, true):
            Text("Valid")
          case (false, _):
            Text("Missing").foregroundStyle(.tertiary)
          case (_, false):
            Text("Error").foregroundStyle(.red)
        }
        
        if Bool.random() {
          Text("Extra")
        }
      }

      TextGroup {

        Text(DummyContent.Strings.paragraphs[3])
          .foregroundStyle(.green)

        Text("Hello")
          .foregroundColor(.red)
          .fontWeight(.bold)

        Text(DummyContent.Strings.paragraphs[1])
          .foregroundColor(.blue)
          .italic()

      }
    }
    .textSelection(.enabled)

  }
}
#if DEBUG
#Preview {
  TextGroupExample()
}
#endif
