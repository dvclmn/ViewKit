//
//  CodeLoadingModel.swift
//  Components
//
//  Created by Dave Coleman on 21/11/2024.
//


import SwiftUI

public struct CodeLoadingConfiguration: Equatable {

  public var seed: UInt64 = 285796
  public var objectCount: Int = 2
  public var nestingDepth: Int = 2

  /// Let's change this to be based on available height, not defined statically
  public var lineCount: Int = 20

  public var spaceFrequency: SpaceFrequency = .normal
  public var spaceWidth: Double = 10

  public var word: WordShape = .init()

  public var indentationWidth: Double = 24

  public var contentWidthRange: ClosedRange<Double> = 0.4...0.9

  public init() {}

}

//@MemberwiseInit(.public)
public struct WordShape: Equatable {
  public var type: WordType = .general
  public var height: Double = 8
  public var rounding: Double = 4
  public var lineHeight: Double = 12
  public var lengthRange: ClosedRange<Double> = 20...60
}

public enum WordType: Equatable {
  case keyword
  case type
  case literal
  case decorator
  case special
  case general

//  var swatch: Swatch {
//    switch self {
//      case .keyword: Swatch.peachOrange20
//      case .type: Swatch.purple30
//      case .literal: Swatch.blue20
//      case .decorator: Swatch.grey10
//      case .special: Swatch.yellow30
//      case .general: Swatch.whiteOff
//    }
//  }

}

extension CodeLoadingConfiguration {

  public enum SpaceFrequency: Double, Equatable {
    case numerous
    case normal
    case occasional

    var rawType: Double {
      switch self {
        case .numerous: return 0.8
        case .normal: return 0.3
        case .occasional: return 0.1
      }
    }
  }
}

public enum CodePart {
  case declaration
  case content
  case closingBrace

  public func width(within availableWidth: Double, range: ClosedRange<Double>) -> Double {
    switch self {
      /// Defining a max width for declarations
      case .declaration: min(availableWidth * 0.7, 200)

      case .content: availableWidth * Double.random(in: range)

      /// Closing brace has a fixed width, not relative
      case .closingBrace: 20
    }
  }
}

public struct CodeBlock {
  let depth: Int
  let properties: Int
  let hasNestedBlock: Bool

  public static func generate(at depth: Int, maxDepth: Int) -> CodeBlock {
    CodeBlock(
      depth: depth,
      properties: Int.random(in: 1...4),
      hasNestedBlock: depth < maxDepth
    )
  }
}
