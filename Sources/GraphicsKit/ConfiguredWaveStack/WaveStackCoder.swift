//
//  WaveStackCoder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import MetaCodable
import VectorKit

struct WaveStackCoder: HelperCoder {
  
  func decode(from decoder: Decoder) throws -> WaveStack {
    print("Decoding wave stack at \(Date.debug)")
    let snapshot = try WaveStackSnapshot(from: decoder)
    
    print()
    var stack = WaveStack()
    stack.restore(from: snapshot)
    return stack
  }
  
  func encode(_ value: WaveStack, to encoder: Encoder) throws {
    let snapshot = value.snapshot()
    try snapshot.encode(to: encoder)
  }
}
