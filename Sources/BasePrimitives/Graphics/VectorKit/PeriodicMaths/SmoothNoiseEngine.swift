//
//  SmoothNoiseEngine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import Foundation

struct SmoothNoiseEngine {
  
  var finalValue: Double = 0
  
  private var currentValue: Double = 0
  private var targetValue: Double = 0
  
  /// When 1, generate new target
  private var progress: Double = 1
  
  /// 0-1: How smooth the transitions are
  var smoothing: Double = 0.5
  
  /// How fast it changes
  var speed: Double = 1.0
  
  /// Overall magnitude
  var amplitude: Double = 1.0
  
  /// 0-1: How many secondary waves to add
  var complexity: Double = 0.5
  
  mutating func update(deltaTime: Double) {
    /// Generate new target when we reach the current one
    if progress >= 1 {
      targetValue = Double.random(in: -1...1)
      progress = 0
    }
    
    /// Update progress
    progress += deltaTime * speed
    
    /// Smooth interpolation using ease-in-out
    let smoothProgress = min(max(progress, 0), 1)
    let t = smoothProgress * smoothProgress * (3 - 2 * smoothProgress)
    
    let mainNoise = currentValue + (targetValue - currentValue) * t
    
    /// Add secondary waves based on complexity
    var secondaryNoise = 0.0
    if complexity > 0 {
      let fast = sin(progress * 8) * 0.2 * complexity
      let faster = sin(progress * 15) * 0.1 * complexity
      secondaryNoise = fast + faster
    }
    currentValue = mainNoise + secondaryNoise
    finalValue = currentValue * amplitude
  }
  
}
