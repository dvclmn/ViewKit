//
//  PopupEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/6/2025.
//

import SwiftUI

/// Usage:
/// ```
/// // View struct
/// @State private var popup = Popup()
///
/// // View body
/// SomeView()
///   .environment(\.popup, popup)
///
/// ```
///
@available(macOS 14.0, *)
struct PopupKey: @preconcurrency EnvironmentKey {
  @MainActor
  static let defaultValue: Popup? = Popup()
}

@available(macOS 14.0, *)
extension EnvironmentValues {
  public var popup: Popup? {
    get { self[PopupKey.self] }
    set { self[PopupKey.self] = newValue }
  }
}
/// Cannot use the below syntax yet, complains about
/// main actor in macro expansion
//extension EnvironmentValues {
//  @MainActor
//  @Entry public var popup: Popup? = Popup()
//}


