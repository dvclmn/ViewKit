//
//  GridFontConfigTests.swift
//  BaseHelpers
//
//  Created by Codex on 5/3/2026.
//

import SwiftUI
import Testing

@testable import BasePrimitives

@Suite("Grid font config resolution")
struct GridFontConfigTests {

  @Test("Domain uses environment style and size when available")
  func domainUsesEnvironmentValues() {
    var env = EnvironmentValues()
    env.isASCIIMode = true
    env.gridFont = .menlo
    env.asciiModeFontSize = 17

    let descriptor = GridFontConfig.domain(.asciiMode).descriptor(in: env)

    #expect(descriptor?.style == .menlo)
    #expect(descriptor?.size == 17)
  }

  @Test("Explicit size overrides environment size for domain")
  func explicitSizeOverridesEnvironment() {
    var env = EnvironmentValues()
    env.isASCIIMode = true
    env.gridFont = .menlo
    env.asciiModeFontSize = 17

    let descriptor = GridFontConfig.domain(.asciiMode, size: 31).descriptor(in: env)

    #expect(descriptor?.style == .menlo)
    #expect(descriptor?.size == 31)
  }
}
