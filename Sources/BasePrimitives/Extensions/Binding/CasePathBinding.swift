//
//  CasePathBinding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/1/2026.
//

import CasePaths
import SwiftUI

extension Binding {
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
