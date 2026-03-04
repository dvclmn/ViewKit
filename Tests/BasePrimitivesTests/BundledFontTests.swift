//
//  BundledFontTests.swift
//  BaseHelpers
//
//  Created by Codex on 4/3/2026.
//

import AppKit
import Testing

@testable import BasePrimitives

@Suite("Bundled fonts")
struct BundledFontTests {

  @Test("BigBlueTerm font file is present in BasePrimitives resources")
  func bigBlueTermResourceExists() {
    #expect(BundledFont.bigBlueTerm.bundledURL != nil)
  }

  @Test("BigBlueTerm registers and resolves through NSFont")
  func bigBlueTermRegisters() {
    #expect(BundledFont.bigBlueTerm.register())

    let postScriptName = BundledFont.bigBlueTerm.postScriptName
    let font = NSFont(name: postScriptName, size: 14)
    #expect(font != nil)
  }
}
