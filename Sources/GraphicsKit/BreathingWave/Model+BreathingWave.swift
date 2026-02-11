//
//  Model+BreathingWave.swift
//  BaseDemos
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import CoreTransferable
import MetaCodable
import VectorKit

@Codable
public struct BreathingWave: Sendable, Equatable, Hashable {

  @CodedBy(WaveStackCoder())
  public var stack: WaveStack

  public var style: WaveStyle
  public var shaders: [ShaderEffect]

  @IgnoreCoding public let ampRange: ClosedRange<Double> = 0...600
  @IgnoreCoding public let freqRange: ClosedRange<Double> = 0...3
  @IgnoreCoding public let cyclesRange: ClosedRange<Double> = 0...30

  public init(
    stack: WaveStack = .init(),
    style: WaveStyle = .init(),
    shaders: [ShaderEffect] = ShaderEffect.wavyPreset02
  ) {
    self.stack = stack
    self.style = style
    self.shaders = shaders
  }
}

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

extension BreathingWave: Transferable {

  public static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(for: BreathingWave.self, contentType: .json)
      .suggestedFileName("New wave preset")
  }
}
