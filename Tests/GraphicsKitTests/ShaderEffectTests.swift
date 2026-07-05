import CoreGraphics
import Foundation
import Testing
@testable import GraphicsKit

struct ShaderEffectTests {

  @Test("shader effects classify application kind without OS-gated usage type")
  func shaderEffectsClassifyApplicationKind() {
    #expect(ShaderEffect.psych(time: 0).applicationKind == .colourEffect)
    #expect(
      ShaderEffect.fisheye(
        origin: .zero,
        radius: 1,
        strength: 1
      ).applicationKind == .distortionEffect
    )
    #expect(
      ShaderEffect.radialBlur(
        origin: .zero,
        strength: 1,
        start: 0,
        end: 1,
        samples: 4
      ).applicationKind == .layerEffect
    )
    #expect(ShaderEffect.checkerboard().applicationKind == .shapeStyle)
  }

  @Test("shader stack keeps only bounded view effects")
  func shaderStackKeepsOnlyBoundedViewEffects() {
    let effects: [ShaderEffect] = [
      .checkerboard(),
      .psych(time: 0),
      .fisheye(origin: .zero, radius: 1, strength: 1),
      .radialBlur(origin: .zero, strength: 1, start: 0, end: 1, samples: 4),
      .crtLines(),
      .filmGrain(time: 0, size: 1, intensity: 1, colour: 0),
    ]

    let normalisedEffects = ShaderStackModifier.normalisedEffects(from: effects)

    #expect(normalisedEffects.count == ShaderStackModifier.maximumEffectCount)
    #expect(normalisedEffects.map(\.applicationKind) == [
      .colourEffect,
      .distortionEffect,
      .layerEffect,
      .colourEffect,
    ])
  }

  @Test("shader composition exposes ordered effects")
  func shaderCompositionExposesOrderedEffects() {
    let effects: [ShaderEffect] = [
      .psych(time: 0),
      .crtLines(),
    ]

    #expect(ShaderComposition.single(effects[0]).effects == [effects[0]])
    #expect(ShaderComposition.sequence(effects).effects == effects)
  }

  @Test("chromatic aberration defaults channel separation for callers")
  func chromaticAberrationDefaultChannelSeparation() {
    let effect = ShaderEffect.chromaticAberration(
      strength: 0.8,
      radialStrength: 5.8
    )

    guard case .chromaticAberration(_, _, let channelSeparation) = effect else {
      #expect(Bool(false))
      return
    }

    expectApproximatelyEqual(Double(channelSeparation), 1.0)
  }

  @Test("chromatic aberration preserves explicit channel separation")
  func chromaticAberrationPreservesExplicitChannelSeparation() throws {
    let effect = ShaderEffect.chromaticAberration(
      strength: 0.8,
      radialStrength: 5.8,
      channelSeparation: 0.25
    )

    let data = try JSONEncoder().encode(effect)
    let json = String(decoding: data, as: UTF8.self)
    #expect(json.contains("\"channelSeparation\":0.25"))

    let decoded = try JSONDecoder().decode(ShaderEffect.self, from: data)

    guard
      case .chromaticAberration(
        let strength,
        let radialStrength,
        let channelSeparation
      ) = decoded
    else {
      #expect(Bool(false))
      return
    }

    expectApproximatelyEqual(Double(strength), 0.8)
    expectApproximatelyEqual(Double(radialStrength), 5.8)
    expectApproximatelyEqual(Double(channelSeparation), 0.25)
  }

  @Test("radial blur preserves start and end payload names")
  func radialBlurPreservesStartAndEndPayloadNames() throws {
    let effect = ShaderEffect.radialBlur(
      origin: CGPoint(x: 0.1, y: -0.2),
      strength: 0.1,
      start: 0.95,
      end: 0.99,
      samples: 20
    )

    let data = try JSONEncoder().encode(effect)
    let json = String(decoding: data, as: UTF8.self)

    #expect(json.contains("\"start\":0.95"))
    #expect(json.contains("\"end\":0.99"))
    #expect(!json.contains("falloff"))

    let decoded = try JSONDecoder().decode(ShaderEffect.self, from: data)

    guard
      case .radialBlur(
        let origin,
        let strength,
        let start,
        let end,
        let samples
      ) = decoded
    else {
      #expect(Bool(false))
      return
    }

    #expect(origin == CGPoint(x: 0.1, y: -0.2))
    expectApproximatelyEqual(Double(strength), 0.1)
    expectApproximatelyEqual(Double(start), 0.95)
    expectApproximatelyEqual(Double(end), 0.99)
    expectApproximatelyEqual(Double(samples), 20)
  }
}
