//
//  DebugText+PrefKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/2/2026.
//

import SwiftUI

public struct DebugTextKey: PreferenceKey {
  public typealias Value = [String]
  public static let defaultValue: Value = []

  public static func reduce(value: inout Value, nextValue: () -> Value) {

    let next = nextValue()
    if next.isEmpty { return }
    //    print("Running `DebugTextKey` reduce at \(Date.debug)")
    //    print("\n\nCurrent value: \(value). \n\nNew data: \(next)\n\n")

    /// Build a set of what we already have
    var seen = Set(value)
    /// Append only new items
    for line in next where !seen.contains(line) {
      value.append(line)
      seen.insert(line)
    }

  }
}

extension View {
  public func addDebugText(
    _ text: [String],
    isEnabled: Bool = true
  ) -> some View {
    return self.preference(
      key: DebugTextKey.self,
      value: isEnabled ? text : []
    )
  }

  public func addDebugText(
    _ text: String...,
    isEnabled: Bool = true
  ) -> some View {
    self.addDebugText(text, isEnabled: isEnabled)
  }

  public func addDebugText(
    _ text: String,
    isEnabled: Bool = true
  ) -> some View {
    self.addDebugText([text], isEnabled: isEnabled)
  }

  public func addDebugText(
    displayString: () -> DisplayString,
    isEnabled: Bool = true
  ) -> some View {
    self.addDebugText(displayString().lines, isEnabled: isEnabled)
  }

  public func addDebugText(
    @DisplayStringBuilder _ content: () -> [DisplayBlock],
    isEnabled: Bool = true
  ) -> some View {
    self.addDebugText(content().lines(), isEnabled: isEnabled)
  }

}
