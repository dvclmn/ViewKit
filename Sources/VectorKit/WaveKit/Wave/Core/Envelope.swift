//
//  Envelope.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct Envelope {
  var attack: Double
  var decay: Double
  var sustain: Double
  var release: Double
  
  public func getValue(at time: Double, triggered: Bool) -> Double {
    /// Basic ADSR implementation
    if !triggered { return 0 }
    
    if time < attack {
      return time / attack
    } else if time < attack + decay {
      let decayProgress = (time - attack) / decay
      return 1.0 - (1.0 - sustain) * decayProgress
    } else {
      return sustain
    }
  }
}
