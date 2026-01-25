//
//  Envelope.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct Envelope {
  var attack: CGFloat
  var decay: CGFloat
  var sustain: CGFloat
  var release: CGFloat
  
  public func getValue(at time: CGFloat, triggered: Bool) -> CGFloat {
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
