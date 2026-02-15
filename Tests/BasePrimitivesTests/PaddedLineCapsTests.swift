//
//  SplitPadString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import Testing

@testable import BasePrimitives

@Suite("Text padding gallery")
struct TextPaddingGalleryTests {

  struct Case: Sendable {
    var name: String
    var input: String
    var width: Int
    var pad: Character = " "
    var alignment: TextPadAlignment = .centre
    var splitOn: Character? = nil
    var caps: LineCaps? = nil
    var surroundTextWithSpaces: Bool = true
    var omitEmptySplits: Bool = true
    var expected: String? = nil  // optional “golden” expected output
  }

  @Test("Gallery cases")
  func gallery() {
    let cases: [Case] = [
      .init(
        name: "No split, centred",
        input: "Hello",
        width: 10,
        expected: "  Hello   "  // (example: depends on your exact surround-space rule)
      ),

      .init(
        name: "No split, leading",
        input: "Hello",
        width: 10,
        alignment: .leading,
        expected: "Hello     "
      ),

      .init(
        name: "Split into 3 chunks, distributed padding",
        input: "Hello@World@Swift",
        width: 25,
        splitOn: "@",
        expected: "Hello     World     Swift"
      ),

      .init(
        name: "Caps with spacing",
        input: "Title",
        width: 14,
        caps: .init("│", "│", padWithSpace: true),
        expected: "│ Title      │"
      ),

      .init(
        name: "Split with caps",
        input: "A@B@C",
        width: 12,
        splitOn: "@",
        caps: .init("[", "]", padWithSpace: false),
        expected: "[A   B   C]"
      ),

      .init(
        name: "Width too small (no crash)",
        input: "This is long",
        width: 4,
        expected: "This is long"  // no clipping policy
      ),
    ]

    for c in cases {
      let result = c.input.paddedLine(
        toFill: c.width,
        pad: c.pad,
        alignment: c.alignment,
        splitOn: c.splitOn,
        caps: c.caps,
        surroundTextWithSpaces: c.surroundTextWithSpaces,
        omitEmptySplits: c.omitEmptySplits
      )

      // Gallery: helpful to inspect while iterating.
      // Keep prints optional / behind a debug flag in real life.
      // print("\(c.name): '\(result)'")

      if let expected = c.expected {
        #expect(result == expected, "\(c.name) failed.\nExpected: '\(expected)'\nGot:      '\(result)'")
      }

      // Invariant: if width is achievable (and pad is 1 char), we can assert exact width.
      if c.width >= result.count {
        // If your policy is “never force to width” when too small,
        // then only assert in cases where you expect fill.
      }
    }
  }

  @Test("Length invariant (single-char pad, width >= minimum)")
  func lengthInvariant() {
    let input = "Hello@World@Swift"
    let width = 40

    let result = input.paddedLine(
      toFill: width,
      pad: " ",
      alignment: .centre,
      splitOn: "@",
      caps: .init("│", "│", padWithSpace: true),
      surroundTextWithSpaces: true
    )

    // This invariant holds if you define “toFill” as “exactly fill when possible”
    #expect(result.count == width)
  }
}
