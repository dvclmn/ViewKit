//
//  InfoBarViewBuilderTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 30/8/2026.
//

import BaseUI
import SwiftUI
import Testing

@Suite("InfoBar view builders")
@MainActor
struct InfoBarViewBuilderTests {

  @Test("supports empty, leading, trailing, and combined presenter content")
  func supportsPresenterContentOverloads() {
    let content = EmptyView()

    _ = content.infoBarView()
    _ = content.infoBarView(
      leadingContent: { Text("Leading") }
    )
    _ = content.infoBarView(
      trailingContent: { Text("Trailing") }
    )
    _ = content.infoBarView(
      leadingContent: { Text("Leading") },
      trailingContent: { Text("Trailing") }
    )
  }
}
