//
//  CasePathBinding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/1/2026.
//

import CasePaths
import SwiftUI

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
