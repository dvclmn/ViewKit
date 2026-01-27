//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import Foundation
import SwiftUI

/// Important: Don't forget to provide the entry point for the modifier:
///
/// ```
/// import SwiftUI
///
/// @main
/// struct ExampleApp: App {
///
///   var body: some Scene {
///     WindowGroup {
///       ContentView()
///         .readModifierKeys() // <- Here
///     }
///   }
/// }
/// ```

//#if canImport(AppKit)

/// AppKit modifiers: `NSEvent.ModifierFlags`
/// SwiftUI modifier: `EventModifiers`
extension EnvironmentValues {
  @Entry public var modifierKeys: Modifiers = []
}

public typealias Keys = Set<KeyEquivalent>
public typealias Modifiers = ModifierKeys

/// A simple bridge between AppKit and SwiftUI modifier keys
public struct ModifierKeys: OptionSet, Sendable, Hashable, Equatable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let capsLock = Self(rawValue: 1 << 0)
  public static let shift = Self(rawValue: 1 << 1)
  public static let control = Self(rawValue: 1 << 2)
  public static let option = Self(rawValue: 1 << 3)
  public static let command = Self(rawValue: 1 << 4)
}

extension ModifierKeys {
  public var isHoldingCapsLock: Bool { contains(.capsLock) }
  public var isHoldingShift: Bool { contains(.shift) }
  public var isHoldingControl: Bool { contains(.control) }
  public var isHoldingOption: Bool { contains(.option) }
  public var isHoldingCommand: Bool { contains(.command) }
}

// MARK: - Initialisers
extension ModifierKeys {
  #if canImport(AppKit)
  public init(from appKitKey: NSEvent.ModifierFlags) {
    self = appKitKey.toCompatibleModifier
  }
  #endif
  struct ModifierMetadata: Hashable {
    let name: String
    let symbol: String
  }

  private static let metadata: [ModifierKeys: ModifierMetadata] = [
    .shift: .init(name: "Shift", symbol: "􀆝"),
    .control: .init(name: "Control", symbol: "􀆍"),
    .option: .init(name: "Option", symbol: "􀆕"),
    .command: .init(name: "Command", symbol: "􀆔"),
    .capsLock: .init(name: "Caps Lock", symbol: "􀆡"),
  ]

  private var individualOptions: [ModifierKeys] {
    ModifierKeys.metadata.keys.filter { contains($0) }
  }

  public func displayName(
    elements: ModifierDisplayElement,
    separator: String = " + ",
    emptyText: String = "None"
  ) -> String {
    let components: [String] = individualOptions.compactMap { option in
      guard let meta = ModifierKeys.metadata[option] else { return nil }

      switch elements {
        case .name:
          return meta.name
        case .icon:
          return meta.symbol
        case .both:
          return "\(meta.symbol) \(meta.name)"
        default:
          return nil
      }
    }

    return components.isEmpty ? emptyText : components.joined(separator: separator)
  }

}

extension ModifierKeys: CustomStringConvertible {
  public var description: String { displayName(elements: .name) }
}

//@available(macOS 15, iOS 18, *)
extension ModifierKeys {
  public init(from swiftUIKey: EventModifiers) {
    self = swiftUIKey.toCompatibleModifier
  }
}

//@available(macOS 15, iOS 18, *)
extension EventModifiers {

  public static var defaultKeys: Self {
    [.command, .shift, .option, .control, .capsLock]
  }

  public var toCompatibleModifier: ModifierKeys {
    var result: ModifierKeys = []
    if contains(.shift) { result.insert(.shift) }
    if contains(.control) { result.insert(.control) }
    if contains(.option) { result.insert(.option) }
    if contains(.command) { result.insert(.command) }
    if contains(.capsLock) { result.insert(.capsLock) }
    return result
  }
}

#if canImport(AppKit)
extension NSEvent.ModifierFlags {
  public var toCompatibleModifier: ModifierKeys {
    var result: ModifierKeys = []
    if contains(.shift) { result.insert(.shift) }
    if contains(.control) { result.insert(.control) }
    if contains(.option) { result.insert(.option) }
    if contains(.command) { result.insert(.command) }
    if contains(.capsLock) { result.insert(.capsLock) }
    return result
  }
}
#endif

public struct ModifierDisplayElement: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let name = Self(rawValue: 1 << 0)
  public static let icon = Self(rawValue: 1 << 1)
  public static let both: Self = [.name, .icon]
}
