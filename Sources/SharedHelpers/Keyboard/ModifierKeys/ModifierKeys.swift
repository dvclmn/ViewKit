//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import EnumMacros
import SwiftUI

//#if canImport(AppKit)

/// AppKit modifiers: `NSEvent.ModifierFlags`
/// SwiftUI modifier: `EventModifiers`
extension EnvironmentValues {
  @Entry public var modifierKeys: Modifiers = []
}

public typealias Keys = Set<KeyEquivalent>
public typealias Modifiers = ModifierKeys

/// Probably only use this if bridging is actually needed
@SetOfOptions<Int>
public struct ModifierKeys: Sendable {
  public enum Options: Int, CaseIterable, Identifiable, Hashable, Equatable {
    case shift
    case option
    case command
    case control
    case capsLock
  }
}

extension ModifierKeys {
  #if canImport(AppKit)
  public init(from event: NSEvent) {
    let flags = event.modifierFlags
//  public init(from appKitKey: NSEvent.ModifierFlags) {
    var result: ModifierKeys = []
    if flags.contains(.shift) { result.insert(.shift) }
    if flags.contains(.control) { result.insert(.control) }
    if flags.contains(.option) { result.insert(.option) }
    if flags.contains(.command) { result.insert(.command) }
    if flags.contains(.capsLock) { result.insert(.capsLock) }
    self = result
    //    self = appKitKey.toCompatibleModifier
  }
  #endif

  public init(from swiftUIKey: EventModifiers) {
    var result: ModifierKeys = []
    if swiftUIKey.contains(.shift) { result.insert(.shift) }
    if swiftUIKey.contains(.control) { result.insert(.control) }
    if swiftUIKey.contains(.option) { result.insert(.option) }
    if swiftUIKey.contains(.command) { result.insert(.command) }
    if swiftUIKey.contains(.capsLock) { result.insert(.capsLock) }
    self = result
  }

  public var isHoldingCapsLock: Bool { contains(.capsLock) }
  public var isHoldingShift: Bool { contains(.shift) }
  public var isHoldingControl: Bool { contains(.control) }
  public var isHoldingOption: Bool { contains(.option) }
  public var isHoldingCommand: Bool { contains(.command) }
}

/// A simple bridge between AppKit and SwiftUI modifier keys
//public struct ModifierKeys: OptionSet, Sendable, Hashable, Equatable {
//  public init(rawValue: Int) {
//    self.rawValue = rawValue
//  }
//  public let rawValue: Int
//
//  public static let capsLock = Self(rawValue: 1 << 0)
//  public static let shift = Self(rawValue: 1 << 1)
//  public static let control = Self(rawValue: 1 << 2)
//  public static let option = Self(rawValue: 1 << 3)
//  public static let command = Self(rawValue: 1 << 4)
//}
//
//extension ModifierKeys {
//  public var isHoldingCapsLock: Bool { contains(.capsLock) }
//  public var isHoldingShift: Bool { contains(.shift) }
//  public var isHoldingControl: Bool { contains(.control) }
//  public var isHoldingOption: Bool { contains(.option) }
//  public var isHoldingCommand: Bool { contains(.command) }
//}

// MARK: - Initialisers
//extension ModifierKeys {

  //  struct ModifierMetadata: Hashable {
  //    let name: String
  //    let symbol: String
  //  }

  //  private static let metadata: [ModifierKeys: ModifierMetadata] = [
  //    .shift: .init(name: "Shift", symbol: "􀆝"),
  //    .control: .init(name: "Control", symbol: "􀆍"),
  //    .option: .init(name: "Option", symbol: "􀆕"),
  //    .command: .init(name: "Command", symbol: "􀆔"),
  //    .capsLock: .init(name: "Caps Lock", symbol: "􀆡"),
  //  ]

  //  private var individualOptions: [ModifierKeys] {
  //    ModifierKeys.metadata.keys.filter { contains($0) }
  //  }

//}


//public struct ModifierDisplayElement: OptionSet, Sendable {
//  public init(rawValue: Int) {
//    self.rawValue = rawValue
//  }
//  public let rawValue: Int
//
//  public static let name = Self(rawValue: 1 << 0)
//  public static let icon = Self(rawValue: 1 << 1)
//  public static let both: Self = [.name, .icon]
//}
