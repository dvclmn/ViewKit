//
//  FontSizeCommands.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/11/2025.
//

#if canImport(AppKit)
import CoreTools
import SwiftUI


public protocol FontSizeControlling: PreferenceSettable
where Prefs: FontSizePreferences {}


public protocol PreferenceSettable: AnyObject, Observable {

  associatedtype Prefs

  var prefs: Prefs { get set }

  func setPref<T>(_ keyPath: WritableKeyPath<Prefs, T>, value: T)
  func prefBinding<T>(_ keyPath: WritableKeyPath<Prefs, T>) -> Binding<T>
  func togglePref(_ keyPath: WritableKeyPath<Prefs, Bool>)
}

public protocol FontSizePreferences {
  var fontSize: CGFloat { get set }
  var fontStepSize: CGFloat { get }
  var fontSizeRange: ClosedRange<CGFloat> { get }
  static var defaultSize: CGFloat { get }
}

@MainActor
@CommandsBuilder

public func FontSizeCommands<Store: FontSizeControlling>(
  _ placement: CommandGroupPlacement,
  store: Bindable<Store>
) -> some Commands {
  let prefs = store.wrappedValue.prefs
  CommandGroup(after: .newItem) {

    Menu("Font Size") {
      Button {
        store.wrappedValue.setPref(
          \.fontSize,
          value: prefs.fontSize.stepping(
            by: prefs.fontStepSize,
            in: prefs.fontSizeRange
          )
        )
      } label: {
        Label("Increase", systemImage: "textformat.size.larger")
      }
      .keyboardShortcut("+", modifiers: .command)

      Button {
        store.wrappedValue.setPref(
          \.fontSize,
          value: prefs.fontSize.stepping(
            by: -prefs.fontStepSize,
            in: prefs.fontSizeRange
          )
        )
      } label: {
        Label("Decrease", systemImage: "textformat.size.smaller")
      }
      .keyboardShortcut("-", modifiers: .command)

      Button {
        if prefs.fontSize != Store.Prefs.defaultSize {
          store.wrappedValue.setPref(\.fontSize, value: Store.Prefs.defaultSize)
          //                popup.showPopup("Reset font size to default")
        }
      } label: {
        Text("Reset")
      }
      .keyboardShortcut("0", modifiers: .command)

    }
  }
}

#endif
