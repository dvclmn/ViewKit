//
//  OptionSet.swift
//  Collection
//
//  Created by Dave Coleman on 30/10/2024.
//


import SwiftUI

/// https://gist.github.com/shaps80/5615c8a71fe26d229bf063d2e7c87a5c

extension Binding where Value: OptionSet & Sendable, Value.Element: Sendable {
  public func toggling(_ value: Value.Element) -> Binding<Bool> {
    .init(
      get: {
        wrappedValue.contains(value)
      },
      set: {
        if $0 {
          wrappedValue.insert(value)
        } else {
          wrappedValue.remove(value)
        }
      }
    )
  }
}

//extension OptionSet {
//  static func describe(
//    _ mapping: [(Self, String)],
//    for value: Self
//  ) -> String {
//    let names = mapping.compactMap { set, text in
//      return value.contains(set) ? text : nil
//    }
////    let names = mapping.compactMap { value.contains($0.0) ? $0.1 : nil }
////    return "\(Self.self)(\(names.joined(separator: ", ")))"
//  }
//}


//public protocol NamedOptionSet: OptionSet, CustomStringConvertible
//where Element == Self {
//  static var namedOptions: [(Self, String)] { get }
//}
//
//extension NamedOptionSet {
//  public var displayString: String {
//    let matches = Self.namedOptions
//      .filter { self.contains($0.0) }
//      .map { $0.1 }
//
//    return matches.isEmpty
//      ? "[]"
//      : "[" + matches.joined(separator: ", ") + "]"
//  }
//
//  public var description: String {
//    displayString
//  }
//}
//
//// MARK: - Conformances
//#if canImport(AppKit)
//extension NSEvent.Phase: NamedOptionSet, @retroactive CustomStringConvertible {
//  public static var namedOptions: [(NSEvent.Phase, String)] {
//    [
//      (.began, "began"),
//      (.stationary, "stationary"),
//      (.changed, "changed"),
//      (.ended, "ended"),
//      (.cancelled, "cancelled"),
//      (.mayBegin, "mayBegin"),
//    ]
//  }
//}
//#endif
