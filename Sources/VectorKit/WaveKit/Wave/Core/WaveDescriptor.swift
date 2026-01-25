//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

extension BreathingWave {
  
  struct SubWave {
    let isEnabled: Bool
    
  }
}

//struct  {
//  let wave: Wave
////  let lineStyle: LineStyle
////  let pointStyle: PointStyle
//  let cycles: Int
//  
//}

/// Suitable for stacking waves together for cool effects
public struct WaveDescriptor {
  let wave: Wave
  let isEnabled: Bool
  let sampleCount: Int
  let cycles: Int
  
}
