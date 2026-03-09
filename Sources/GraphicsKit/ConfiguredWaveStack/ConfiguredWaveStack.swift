//
//  ConfiguredWaveStack.swift
//  BaseDemos
//
//  Created by Dave Coleman on 25/1/2026.
//

import BasePrimitives
import CoreTransferable
import MetaCodable

@Codable
public struct ConfiguredWaveStack: Sendable, Equatable, Hashable {

  @CodedBy(WaveStackCoder())
  public var stack: WaveStack

  public var sampleCount: Int
  public var interpolation: WaveInterpolation

  public var style: WaveStyle
  public var shaders: [ShaderEffect]

  public init(
    stack: WaveStack = .init(),
    samples: Int = 20,
    interpolation: WaveInterpolation = .cubic(),
    style: WaveStyle = .init(),
    shaders: [ShaderEffect] = [ShaderEffect.chromaticPresetA]
  ) {
    self.stack = stack
    self.sampleCount = samples
    self.interpolation = interpolation
    self.style = style
    self.shaders = shaders
  }
}

extension ConfiguredWaveStack: Transferable {

  public static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(for: ConfiguredWaveStack.self, contentType: .json)
      .suggestedFileName("New wave preset")
  }
}
