//
//  String+Repeater.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

@resultBuilder
struct PatternBuilder {
  static func buildBlock(_ components: PatternComponent...) -> [PatternComponent] {
    return components
  }
}

public protocol PatternComponent {
  func apply(to string: inout String, remainingCount: inout Int)
}

struct PatternForEach: PatternComponent {
  let components: [PatternComponent]

  func apply(to string: inout String, remainingCount: inout Int) {
    for component in components {
      component.apply(to: &string, remainingCount: &remainingCount)
      if remainingCount == 0 { break }
    }
  }
}

public struct CharacterPattern: PatternComponent {
  let char: Character
  let count: Int

  public func apply(to string: inout String, remainingCount: inout Int) {
    let repeatCount = min(count, remainingCount)
    string += String(repeating: char, count: repeatCount)
    remainingCount -= repeatCount
  }
}

extension String {
  public static func pattern(totalCount: Int, @PatternBuilder _ builder: () -> [PatternComponent]) -> String {
    var result = ""
    var remainingCount = totalCount
    let components = builder()

    while remainingCount > 0 {
      for component in components {
        component.apply(to: &result, remainingCount: &remainingCount)
        if remainingCount == 0 { break }
      }
    }

    return result
  }

  public init(pattern: (Character, Int)..., totalCount: Int) {
    self = String.pattern(totalCount: totalCount) {
      PatternForEach(components: pattern.map { repeating($0.0, count: $0.1) })
    }
  }

  public static var dashDotPattern: (Int) -> String {
    return { count in

      String.pattern(totalCount: count) {
        character("-")
        character(".")
      }
    }
  }
}
//
func character(_ char: Character) -> PatternComponent {
  return CharacterPattern(char: char, count: 1)
}

func repeating(_ char: Character, count: Int) -> PatternComponent {
  return CharacterPattern(char: char, count: count)
}
