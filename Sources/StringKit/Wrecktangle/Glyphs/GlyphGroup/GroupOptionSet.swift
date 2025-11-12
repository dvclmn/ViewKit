//
//  GroupOptionSet.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box.GlyphGroup {
  public struct Presets: OptionSet, Sendable, Hashable {
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    public let rawValue: Int

    public static let straightsThin = Self(rawValue: 1 << 0)
    public static let straightsThick = Self(rawValue: 1 << 1)
    public static let joinsThin = Self(rawValue: 1 << 2)
    public static let joinsThick = Self(rawValue: 1 << 3)
    public static let joinsThickExtThinInt = Self(rawValue: 1 << 4)
    public static let cornersThinSharp = Self(rawValue: 1 << 5)
    public static let cornersThickSharp = Self(rawValue: 1 << 6)

    public static let straights: Self = [
      .straightsThin,
      .straightsThick,
    ]
    public static let joins: Self = [
      .joinsThin,
      .joinsThick,
      .joinsThickExtThinInt,
    ]
    public static let corners: Self = [
      .cornersThinSharp,
      .cornersThickSharp,
    ]
  }
}
