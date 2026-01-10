//
//  TextGroup.swift
//  Components
//
//  Created by Dave Coleman on 6/11/2024.
//

import BasePrimitives
import SwiftUI

public struct TextGroup: View {

  let content: Text

  public init(
    separator: String = "\n",
    @TextBuilder content: () -> [Text]
  ) {
    self.content = content().joined(separator: Text(separator))
//    self.init(separator: Text(separator), content: content)
  }
//
//  public init(
//    separator: Text,
//    @TextBuilder content: () -> [Text]
//  ) {
//    self.content = content().joined(separator: separator)
//  }

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

