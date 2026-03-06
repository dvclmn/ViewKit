//
//  KeyPressable.swift
//  BaseComponents
//
//  Created by Dave Coleman on 14/5/2025.
//

import SwiftUI

/// Update: I think this can be retired, as I've since realised this is all
/// possible with standard SwiftUI?
/// The idea here is that this is placed wherever access is available
/// to define and execute the commands that the keys should trigger
//public protocol KeyPressCommandHandler {
//  associatedtype Command: KeyPressable
//  func handleCommand(_ command: Command)
//}
//
//public protocol KeyPressable: CaseIterable {
//  var keyboardShortcut: KeyboardShortcut { get }
//  static func fromKey(_ key: KeyEquivalent) -> Self?
//}
//
//extension KeyPressable {
//
//  /// Map from key to command
//  public static func fromKey(_ key: KeyEquivalent) -> Self? {
//
//    /// Check all possible cases and return the one that matches
//    for command in Self.allCases where command.keyboardShortcut.key == key {
//      return command
//    }
//    return nil
//  }
//}
