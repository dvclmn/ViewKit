//
//  WavePath.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

public struct WaveValues {
  let offsetV: CGFloat
  let offsetH: CGFloat
  let offsetR: CGFloat
  
  public init(v: CGFloat, h: CGFloat, r: CGFloat) {
    self.offsetV = v
    self.offsetH = h
    self.offsetR = r
  }
}

//extension WaveValues {
//  public static func build(
//    
//  ) -> Self {
//    
//  }
//}



/// Global while I'm sketching this out
//public func drawWave(
//  sampleCount: Int,
//  size: CGSize, // From the Canvas
//  getValues: @escaping (_ index: Int) -> WaveValues
//) {
//  
//  for i in 0..<sampleCount {
//    
//    /// Calculate base positions, as a static anchor. Divides by 2
//    /// to center the spine of the main wave.
//    let baseX = size.width / 2
//    
//    /// Distribute dots vertically.
//    /// Higher frequency = shorter total wave height.
//    let index = i.normalisedIndex(for: sampleCount)
//    let baseY = index.lerp(from: size.height, to: 0)
//    
//    // MARK: - Wave Samples
//    /// Calculate offsets and dot radius modulations — dynamic movement
//    let waveOffsets = getValues(i)
//    //    let xOffset =
//    //    waveHCached?.sample(
//    //      state: horizontalState,
//    //      at: index
//    //    ) ?? .zero
//    //    
//    //    let yOffset =
//    //    waveVCached?.sample(
//    //      state: verticalState,
//    //      at: index
//    //    ) ?? .zero
//    //    
//    //    let radiusOffset =
//    //    waveDRCached?.sample(
//    //      state: radiusState,
//    //      at: index
//    //    ) ?? .zero
//  }
//}
