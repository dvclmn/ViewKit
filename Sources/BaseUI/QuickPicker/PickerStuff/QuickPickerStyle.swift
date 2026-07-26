//
//  Pickable.swift
//  BaseComponents
//
//  Created by Dave Coleman on 14/5/2025.
//

import Foundation

/// The presentation used by ``QuickPicker``.
///
/// This is deliberately separate from SwiftUI's `PickerStyle`: `QuickPicker`
/// owns its items and selection binding, so it can offer a capsule treatment
/// without relying on SwiftUI's private picker-style implementation details.
public enum QuickPickerStyle: Sendable {
  case plain
  case capsule
}
