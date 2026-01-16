//
//  AppHandler.swift
//  Moving shapes
//
//  Created by Dave Coleman on 27/1/2025.
//

import Sharing
import SwiftUI

@Observable
final class AppHandler {
  @ObservationIgnored @Shared(.drawing) var drawing
}

//extension AppHandler {
//  func setPref<T>(
//    _ keyPath: WritableKeyPath<Preferences, T>,
//    value: T
//  ) {
//    self.$preferences.withLock { $0[keyPath: keyPath] = value }
//  }
//
//  func prefBinding(
//    _ keyPath: WritableKeyPath<Preferences, Bool>
//  ) -> Binding<Bool> {
//    Binding {
//      self.preferences[keyPath: keyPath]
//    } set: {
//      self.setPref(keyPath, value: $0)
//    }
//  }
//}
