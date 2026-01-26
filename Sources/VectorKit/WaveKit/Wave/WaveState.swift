//
//  WaveState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import SwiftUI

/// This is the "Stateful" version of your wave.
/// It stays alive in your view or view model.
//@Observable
//public final class WaveState {
//  public var parameter = ContinuousParameter()
//  private var lastFrequency: Double = 0
//
//  /// This is called whenever the configuration changes.
//  public func update(with config: Wave) {
//    let now = Date().timeIntervalSinceReferenceDate
//    // Only sync if the frequency actually changed!
//    if config.frequency != lastFrequency {
//      parameter.sync(at: now, oldFrequency: lastFrequency, newFrequency: config.frequency)
//      lastFrequency = config.frequency
//    }
//  }
//}
