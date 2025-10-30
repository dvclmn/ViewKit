//
//  TextGroup.swift
//  Components
//
//  Created by Dave Coleman on 6/11/2024.
//

import SharedHelpers
import SwiftUI

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
