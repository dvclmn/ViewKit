//
//  Shortcuttable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

//import SwiftUI

//public protocol Shortcuttable {
//  var keyboardShortcut: KeyboardShortcut? { get }
//  var areShortcutsEnabled: Bool { get }
//}
//
//extension Shortcuttable {
//  public var areShortcutsEnabled: Bool { false }
//  public var keyboardShortcut: KeyboardShortcut? { nil }
//}
//
//extension Shortcuttable
//where Self: CaseIterable & Equatable & Sendable & LabeledItem, Self.AllCases.Index == Int {
//  public var keyboardShortcut: KeyboardShortcut? {
//    guard let index = Self.allCases.firstIndex(of: self), index < 9 else {
//      return nil
//    }
//    return KeyboardShortcut(
//      KeyEquivalent(Character(String(index + 1))),
//      modifiers: .command
//    )
//  }
//
//  @CommandsBuilder
//  public func tabShortcut(_ newTab: @escaping @Sendable (Self) -> Void) -> some Commands {
//    if areShortcutsEnabled {
//
//      CommandGroup(after: .windowArrangement) {
//        ForEach(Self.allCases.toArray) { tab in
//          Button("Go to \(tab.label.text)") {
//            newTab(tab)
//          }
//          .keyboardShortcut(self.keyboardShortcut)
//
//        }
//
//      }
//    }
//  }
//}
