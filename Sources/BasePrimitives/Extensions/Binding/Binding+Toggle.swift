//
//  Binding+Toggle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

extension Binding where Value: OptionSet & Sendable, Value.Element == Value {
  /// Returns a Boolean binding that toggles the presence of a single option in the set.
  func contains(_ element: Value) -> Binding<Bool> {
    Binding<Bool>(
      get: { wrappedValue.contains(element) },
      set: { isIncluded in
        if isIncluded {
          wrappedValue.insert(element)
        } else {
          wrappedValue.remove(element)
        }
      }
    )
  }
}

extension Binding where Value: OptionSet {

  /// Returns a Boolean binding that represents membership of `option` inside an OptionSet.
  ///
  /// - Parameters:
  ///   - option: The option whose membership is being toggled.
  ///   - clearing: Optional set of options to clear when enabling this one.
  ///   - preventEmpty: If true, removing the final remaining option becomes a no-op.
  @MainActor
  public func bindingToggle(
    option: Value.Element,
    clearing others: Value? = nil,
    preventEmpty: Bool = false
  ) -> Binding<Bool> {
    Binding<Bool> {
      wrappedValue.contains(option)
    } set: { isOn in
      if isOn {
        if let others {
          wrappedValue.subtract(others)
        }
        wrappedValue.insert(option)
      } else {
        var proposed = wrappedValue
        proposed.remove(option)

        if preventEmpty && proposed.isEmpty {
          return  // no-op
        }

        wrappedValue = proposed
      }
    }
  }

  /// Returns a Boolean binding that represents membership of `option` inside an OptionSet.
  /// Setting `true` inserts the option; setting `false` removes it.
  ///
  /// ```
  /// Toggle(
  ///   "Square only",
  ///   isOn: $components.bindingToggle(option: .square, clearing: .all)
  /// )
  /// ```
  @MainActor
  public func bindingToggle(
    option: Value.Element,
    clearing others: Value? = nil
  ) -> Binding<Bool> {
    Binding<Bool> {
      wrappedValue.contains(option)
    } set: { isOn in
      if isOn {
        if let others { wrappedValue.subtract(others) }
        wrappedValue.insert(option)
      } else {
        wrappedValue.remove(option)
      }
    }
  }

  /// Like `bindingToggle(option:)`, but can optionally clear other options when enabling.
  //  @MainActor
  //  public func bindingToggle(
  //    option: Option,
  //
  //  ) -> Binding<Bool>
  //  where Value == Option, Option: OptionSet {
  //
  //    Binding<Bool> {
  //      wrappedValue.contains(option)
  //    } set: { isOn in
  //      if isOn {
  //
  //        wrappedValue.insert(option)
  //      } else {
  //        wrappedValue.remove(option)
  //      }
  //    }
  //  }
}

extension Binding {

  /// Returns a Boolean binding that toggles the Bool for the given Key in the Dictionary
  @MainActor
  public func bindingToggle<T>(key: T) -> Binding<Bool>
  where Value == [T: Bool], T: Hashable {
    Binding<Bool> {
      wrappedValue[key] ?? false
    } set: {
      wrappedValue[key] = $0
    }
  }
  //  func contains(_ element: Value) -> Binding<Bool> {
  //    Binding<Bool>(
  //      get: { wrappedValue.contains(element) },
  //      set: { isIncluded in
  //        if isIncluded {
  //          wrappedValue.insert(element)
  //        } else {
  //          wrappedValue.remove(element)
  //        }
  //      }
  //    )
  //  }

}
