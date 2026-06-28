//
//  CaseBinding.swift
//  ViewKit
//
//  Created by Dave Coleman on 16/2/2026.
//

import CasePaths
import SwiftUI

/// Provides bindable access to associated values of a specific enum case
///
/// Intended to be used conditionally, such as:
/// `if let binding = proxy.case(\.wave)) {...}`
@MainActor
public struct CaseBinding<Root, Value> {
  let casePath: AnyCasePath<Root, Value>
  let root: Binding<Root>

  public func binding() -> Binding<Value>? {
    guard casePath.extract(from: root.wrappedValue) != nil else {
      return nil
    }

    return Binding<Value>(
      get: { casePath.extract(from: root.wrappedValue)! },
      set: { newValue in
        root.wrappedValue = casePath.embed(newValue)
      }
    )
  }
}

extension Binding {
  /// This is usually not for use like this: `something[dynamicMember: \.something]`
  ///
  /// Just let it be part of how @dynamicMemberLookup works, like this
  /// ```
  /// if let binding = store.dataBinding().shaderA.chromaticAberration {
  ///   QuickSlider("Strength", value: binding.strength)
  /// }
  /// ```
  @MainActor
  public subscript<Case>(dynamicMember keyPath: CaseKeyPath<Value, Case>) -> Binding<Case>?
  where Value: CasePathable {
    Binding<Case>(
      Binding<Case?>(
        get: { self.wrappedValue[case: keyPath] },
        set: { newValue, transaction in
          guard let newValue else { return }
          self.transaction(transaction).wrappedValue[case: keyPath] = newValue
        }
      )
    )
  }
}
