//
//  BoxView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import StringKit
import SwiftUI

public struct BoxView: View {
  @Environment(\.glyphSet) private var glyphSet

  let width: Int
  let content: Text

  public init(
    separator: String = "\n",
    width: Int,
    @TextBuilder content: () -> [Text]
  ) {
    self.width = width
    self.content = content().joined(separator: Text(separator))
  }

  public var body: some View {
    content
  }
}

extension BoxView {
  
}
