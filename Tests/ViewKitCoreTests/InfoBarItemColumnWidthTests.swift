//
//  InfoBarItemColumnWidthTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 2/9/2026.
//

import StringTools
import Testing
import ViewKitCore

struct InfoBarItemColumnWidthTests {
  @Test
  func stringInitialiserDefaultsToIntrinsicWidth() {
    let item = InfoBarItem(
      label: nil,
      content: "Select",
    )

    #expect(item.content.width == .intrinsic)
    #expect(item.resolvedContent == "Select")
  }

  @Test
  func stringInitialiserRetainsTheRequestedColumnWidth() {
    let item = InfoBarItem(
      label: nil,
      content: "7",
      columnWidth: .fixed(5),
    )

    #expect(item.content.sourceContent == "7")
    #expect(item.content.width == .fixed(5))
    #expect(item.resolvedContent == "    7")
  }
}
