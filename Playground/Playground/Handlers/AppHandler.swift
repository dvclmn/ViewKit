//
//  AppHandler.swift
//  Moving shapes
//
//  Created by Dave Coleman on 27/1/2025.
//

import CoreTools
import LilyPad
import Sharing
import SwiftUI
import VectorKit

@Observable
final class AppHandler {
  @ObservationIgnored @Shared(.drawing) var drawing: DrawingData
  @ObservationIgnored @Shared(.preferences) var preferences: Preferences

  var strokeStyle: StrokeConfig = .init()
  //  var strokeHandler: StrokeHandler = .init()
  //  var activeStroke: Stroke?
  //  var strokeDensity: Int = 3 // Stride
  //  var pressure: CGFloat = 1
  var isDrawingEnabled: Bool = false
  //  var pathStyle: PathStyleConfig = .smooth
  var isInspectorPresented: Bool = true
}
extension AppHandler {
  func setDrawing<T>(
    _ keyPath: WritableKeyPath<DrawingData, T>,
    value: T
  ) {
    self.$drawing.withLock { $0[keyPath: keyPath] = value }
  }

  func setDrawing(
//    _ keyPath: WritableKeyPath<DrawingData, T>,
    perform: (inout DrawingData) -> Void
  ) {
    self.$drawing.withLock { perform(&$0) }
  }

  func setDrawing<T>(
    _ keyPath: WritableKeyPath<DrawingData, T>,
    value: () -> T
  ) {
    self.$drawing.withLock { $0[keyPath: keyPath] = value() }
  }

}

extension AppHandler {
  func setPref<T>(
    _ keyPath: WritableKeyPath<Preferences, T>,
    value: T
  ) {
    self.$preferences.withLock { $0[keyPath: keyPath] = value }
  }

  func prefBinding<T>(
    _ keyPath: WritableKeyPath<Preferences, T>
  ) -> Binding<T> {
    Binding {
      self.preferences[keyPath: keyPath]
    } set: {
      self.setPref(keyPath, value: $0)
    }
  }
}
