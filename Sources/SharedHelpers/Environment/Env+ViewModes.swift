//
//  Env+ViewModels.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/9/2025.
//

import SwiftUI

extension EnvironmentValues {

  //  @Entry public var viewModes: ViewModes = []
  /// note: The below is not currently true, but may be the case
  /// once I figure out usage of ``ViewModes`` better
  /// ~~Below are aliases for `viewModes.contains(.debug)`.
  /// Prefer `viewModes` for new code.~~

  @Entry public var isDebugMode: Bool = false
  @Entry public var isEmphasised: Bool = false

  /// Note: `isCompactMode` is handy to have, for basic on/off
  /// declaration, but at times more granular view sizing control is needed,
  /// so prefer use of native `controlSize` in those cases/
  @Entry public var isCompactMode: Bool = false
  @Entry public var isEditable: Bool = true
}
