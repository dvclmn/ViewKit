//
//  ConfiguredWaveStack.swift
//  BaseDemos
//
//  Created by Dave Coleman on 25/1/2026.
//

import CoreTransferable
import MetaCodable
import BasePrimitives
//import VectorKit

@Codable
public struct ConfiguredWaveStack: Sendable, Equatable, Hashable {

  @CodedBy(WaveStackCoder())
  public var stack: WaveStack
  //  public var primaryWaveKey: AnyWaveKey?

  public var sampleCount: Int
  public var interpolation: WaveInterpolation

  public var style: WaveStyle
  public var shaders: [ShaderEffect]

  /// If no primary wave key supplied, will default to first in the stack
  public init(
    stack: WaveStack = .init(),
    //    primaryWave: AnyWaveKey? = nil,
    samples: Int = 20,
    interpolation: WaveInterpolation = .cubic(),
    style: WaveStyle = .init(),
    shaders: [ShaderEffect] = ShaderEffect.wavyPreset02
  ) {
    self.stack = stack
    //    self.primaryWaveKey = primaryWave
    self.sampleCount = samples
    self.interpolation = interpolation
    self.style = style
    self.shaders = shaders
  }
}

//extension ConfiguredWaveStack {
//
//  public var primaryWave: ConfiguredWave? {
//    guard let key = primaryWaveKey,
//          let typedKey = key.as
//    else { return nil }
//    stack[key.]
//  }
//
//}

extension ConfiguredWaveStack: Transferable {

  public static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(for: ConfiguredWaveStack.self, contentType: .json)
      .suggestedFileName("New wave preset")
  }
}
