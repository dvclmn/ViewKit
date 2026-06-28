//
//  InfoBarSectionKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import Foundation

/// A type safe way to declare a section for a group of Info bar items.
/// This is then used in ``InfoBar``
/// Example use:
/// ```
/// public enum ExampleSectionKey: InfoBarSectionKey {
///   public static let title = "Example Section"
/// }
/// ```
public protocol InfoBarSectionKey: Hashable, Sendable {
  static var title: String { get }
}

//extension InfoBarSectionKey {
//  public static var `default`: Self { DebugSectionKey.self }
//}

public struct InfoBarSectionID: Hashable, Sendable {
  private let id: ObjectIdentifier
  public let title: String

  public init<K: InfoBarSectionKey>(_ key: K.Type) {
    self.id = ObjectIdentifier(key)
    self.title = key.title
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension InfoBarSectionID {
  public static let exampleID: Self = .init(DebugSectionKey.self)
}

// MARK: - Debug convenience
/// Consider  other cases where very simple InfoBarItems way want to be
/// created, that are even just string based, no ceremoney, that aren't
/// neccesarily debug items.
public enum DebugSectionKey: InfoBarSectionKey {
  public static let title: String = "Debug"
}
