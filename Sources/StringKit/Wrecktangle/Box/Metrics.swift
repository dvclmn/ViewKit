//
//  Metrics.swift
//  Box
//
//  Created by Dave Coleman on 24/8/2024.
//

extension Box {

  public struct Metrics: OptionSet, Sendable, Codable {
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    public let rawValue: Int

    public static let widthCounter = Self(rawValue: 1 << 0)
    public static let invisibles = Self(rawValue: 1 << 1)
    public static let lineNumbers = Self(rawValue: 1 << 2)
    public static let all: Self = [.widthCounter, .invisibles, .lineNumbers]
  }
}

