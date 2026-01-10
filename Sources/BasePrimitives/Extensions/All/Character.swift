//
//  Character.swift
//  Collection
//
//  Created by Dave Coleman on 15/12/2024.
//

import Foundation

extension Character {

  /// Returns latin alphabet letter, starting from 'a'
  public static func letter(for index: Int) -> Character? {
    let isInBounds = (0..<26).contains(index)
    let startChar = Character("a").unicodeScalars.first
    let nextScalar = startChar?.value.advanced(by: index)

    guard isInBounds,
      let nextScalar,
      let result = UnicodeScalar(nextScalar)
    else { return nil }

    return Character(result)
  }

  public var descriptiveName: String {
    switch self {
      case " ": "Space"
      case "\n": "New Line"
      case "\t": "Tab"
      case "(": "Left Parenthesis"
      case ")": "Right Parenthesis"
      case "[": "Left Square Bracket"
      case "]": "Right Square Bracket"
      case "{": "Left Curly Brace"
      case "}": "Right Curly Brace"
      case "<": "Less Than Sign"
      case ">": "Greater Than Sign"
      case "&": "Ampersand"
      case "@": "At Sign"
      case "#": "Number Sign"
      case "%": "Percent Sign"
      case "$": "Dollar Sign"
      default: "undefined"
    }
  }
}

// https://gist.github.com/john-mueller/cb5fe3d39afe47ad7c94a84a6670e010
extension Character: @retroactive Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(String(self))
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)

    guard let character = string.first else {
      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Empty String cannot be converted to Character."
      )
    }

    guard string.count == 1 else {
      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Multi-character String cannot be converted to Character."
      )
    }

    self = character
  }

}

extension Array where Element == Character {
  public static func padded(
    with char: Character,
    count: Int
  ) -> [Character] {
    guard count > 0 else { return [] }
    return Array(repeating: char, count: count)
  }
}
