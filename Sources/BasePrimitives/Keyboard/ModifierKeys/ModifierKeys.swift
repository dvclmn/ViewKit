//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import EnumMacros
import SwiftUI

/// AppKit modifiers: `NSEvent.ModifierFlags`
/// SwiftUI modifier: `EventModifiers`
extension EnvironmentValues {

}

/// This `Modifiers` is used a lot throughout this package and various project
public typealias Modifiers = ModifierKeys

/// A representation of Modifier keys that doesn't use SwiftUI or AppKit
@SetOfOptions<Int>
public struct ModifierKeys: Sendable, Hashable {
  public enum Options: Int, CaseIterable, Identifiable, Hashable, Equatable {
    case shift
    case option
    case command
    case control
    case capsLock
    case numericPad
  }
}

extension ModifierKeys.Options {
  public var id: Int { rawValue }
}

extension ModifierKeys {
  #if canImport(AppKit)
  public init(from event: NSEvent) {
    let flags = event.modifierFlags
    var result: ModifierKeys = []
    if flags.contains(.shift) { result.insert(.shift) }
    if flags.contains(.control) { result.insert(.control) }
    if flags.contains(.option) { result.insert(.option) }
    if flags.contains(.command) { result.insert(.command) }
    if flags.contains(.capsLock) { result.insert(.capsLock) }
    if flags.contains(.numericPad) { result.insert(.numericPad) }
    self = result
  }
  #endif

  public init(from swiftUIKey: EventModifiers) {
    var result: ModifierKeys = []
    if swiftUIKey.contains(.shift) { result.insert(.shift) }
    if swiftUIKey.contains(.control) { result.insert(.control) }
    if swiftUIKey.contains(.option) { result.insert(.option) }
    if swiftUIKey.contains(.command) { result.insert(.command) }
    if swiftUIKey.contains(.capsLock) { result.insert(.capsLock) }
    if swiftUIKey.contains(.numericPad) { result.insert(.numericPad) }
    self = result
  }

  public var isHoldingCapsLock: Bool { contains(.capsLock) }
  public var isHoldingShift: Bool { contains(.shift) }
  public var isHoldingControl: Bool { contains(.control) }
  public var isHoldingOption: Bool { contains(.option) }
  public var isHoldingCommand: Bool { contains(.command) }
}

extension ModifierKeys {

  struct Metadata: Hashable {
    let name: String
    let symbol: String
  }

  private static let metadata: [ModifierKeys: ModifierKeys.Metadata] = [
    .shift: .init(name: "Shift", symbol: "􀆝"),
    .control: .init(name: "Control", symbol: "􀆍"),
    .option: .init(name: "Option", symbol: "􀆕"),
    .command: .init(name: "Command", symbol: "􀆔"),
    .capsLock: .init(name: "Caps Lock", symbol: "􀆡"),
    .numericPad: .init(name: "Numeric Pad", symbol: "􀅱"),
  ]

  //  private var individualOptions: [ModifierKeys] {
  //    ModifierKeys.metadata.keys.filter { contains($0) }
  //  }

}

public struct ModifierDisplayElements: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let name = Self(rawValue: 1 << 0)
  public static let icon = Self(rawValue: 1 << 1)
  public static let both: Self = [.name, .icon]
}
