//
//  WaveStack+Binding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import SwiftUI

extension Binding where Value == WaveStack {
  /// Creates a binding to a specific property of a WaveDescriptor stored in the stack
  @MainActor
  public func subBinding<K: WaveKey, T>(for key: K.Type, path: WritableKeyPath<WaveDescriptor, T>) -> Binding<T> where K.Value == WaveDescriptor {
    Binding<T>(
      get: {
        /// Get the descriptor from the stack, then the specific property via KeyPath
        let descriptor = self.wrappedValue[key]
        return descriptor[keyPath: path]
      },
      set: { newValue in
        /// Mutate the descriptor, then shove it back into the stack to trigger UI updates
        var descriptor = self.wrappedValue[key]
        descriptor[keyPath: path] = newValue
        self.wrappedValue[key] = descriptor
      }
    )
  }
}
