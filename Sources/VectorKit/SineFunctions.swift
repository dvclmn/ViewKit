//
//  SineFunctions.swift
//  Collection
//
//  Created by Dave Coleman on 21/11/2024.
//

import Foundation

public struct Sine {
  
  /// If you want [-1, 1] range instead:
  /// `let value = sine // Skip normalization`
  ///
  /// If you want a custom range [min, max]:
  /// ```
  /// let min: CGFloat = 10
  /// let max: CGFloat = 20
  /// let customRange = normalised * (max - min) + min
  /// ```
  ///
  /// If you want to use cosine instead (90° phase shift):
  /// `let cosine = cos(interval * angularFrequency)`
  ///
  /// If you want to adjust the amplitude:
  /// ```
  /// let amplitude = 0.5 // Less than 1 for smaller range
  /// let modifiedSine = sin(interval * angularFrequency) * amplitude
  /// ```

  public static func getSineWave(from interval: TimeInterval, frequency: CGFloat = 0.2) -> CGFloat {
    
    /// 2. Define your frequency (controls speed of oscillation)
    /// Lower numbers = slower oscillation
    /// Higher numbers = faster oscillation
    
    /// 3. Create the angular frequency (radians per second)
    let angularFrequency = 2 * CGFloat.pi * frequency
    
    /// 4. Calculate the sine wave
    let sine = sin(interval * angularFrequency)
    
    /// 5. Normalize from [-1, 1] to [0, 1]
//    let normalised = (sine + 1) / 2
    
    return sine
    
  }
  
  public static func getSineWave(from date: Date, frequency: CGFloat = 0.2) -> CGFloat {
    /// 1. Get the time interval (seconds since reference date)
    let interval = date.timeIntervalSinceReferenceDate
    
    return getSineWave(from: interval, frequency: frequency)
    
  }
  
  
  
}
