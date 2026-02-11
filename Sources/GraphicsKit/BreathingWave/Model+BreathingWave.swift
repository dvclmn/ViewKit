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
struct BreathingWave: Sendable, Equatable, Hashable, Codable {

//  @CodedBy(WaveStackCoder())
//  var stack = WaveStack()
  var style = FloatWaveStyle()
//
  @IgnoreCoding static let ampRange: ClosedRange<Double> = 0...600
  @IgnoreCoding static let freqRange: ClosedRange<Double> = 0...3
  @IgnoreCoding static let cyclesRange: ClosedRange<Double> = 0...30

  var shaders: [ShaderEffect] = ShaderEffect.wavyPreset02
}

struct WaveStackCoder: HelperCoder {
  func decode(from decoder: Decoder) throws -> WaveStack {
    let snapshot = try WaveStackSnapshot(from: decoder)
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

  static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(for: BreathingWave.self, contentType: .json)
      .suggestedFileName("New wave preset")
  }
}

//
//extension BreathingWave {
//  enum CodingKeys: String, CodingKey {
//    case stack, style
//  }
//
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//
//    /// Handle wave style
//    let style = try container.decode(FloatWaveStyle.self, forKey: .style)
//    self.style = style
//
//    /// For `WaveStack`, encode the projection and apply it to the stack
//    let projection = try container.decode(WaveStackSnapshot.self, forKey: .stack)
//    self.stack = WaveStack()
//    self.stack.restore(from: projection)
//  }
//
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//
//    try container.encode(style, forKey: .style)
//
//    /// Encode the stack as a projection
//    let projection = stack.snapshot()
//    try container.encode(projection, forKey: .stack)
//  }
//}
