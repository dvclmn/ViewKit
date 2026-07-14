import CoreGraphics
import Foundation
import Testing
@testable import GraphicsKit

struct ShaderEffectTests {

  @Test("preset factory covers every effect with two distinct variants")
  func presetFactoryCoversEveryEffect() throws {
    let kinds = ShaderEffect.PresetKind.allCases
    #expect(kinds.count == 2)

    for effect in ShaderEffect.Meta.allCases {
      let presets = kinds.map { kind in
        ShaderEffect.preset(effect, kind: kind, time: 4)
      }

      #expect(presets.allSatisfy { $0.meta == effect })
      #expect(try JSONEncoder().encode(presets[0]) != JSONEncoder().encode(presets[1]))
    }
  }

  @Test("preset factory resolves pixel-space effects from the supplied size")
  func presetFactoryUsesSuppliedSize() {
    let size = CGSize(width: 400, height: 240)

    let fisheye = ShaderEffect.preset(.fisheye, in: size)
    guard case .fisheye(let origin, _, _) = fisheye else {
      #expect(Bool(false))
      return
    }

    let ripple = ShaderEffect.preset(.ripplePush, kind: .pronounced, in: size)
    guard case .ripplePush(let location, let velocity) = ripple else {
      #expect(Bool(false))
      return
    }

    #expect(origin == CGPoint(x: 200, y: 120))
    #expect(location == CGPoint(x: 200, y: 120))
    #expect(velocity == CGPoint(x: 80, y: -19.2))
  }

  @Test("shader effects classify application kind without OS-gated usage type")
  func shaderEffectsClassifyApplicationKind() {
    #expect(ShaderEffect.psych(time: 0).applicationKind == .colourEffect)
    #expect(ShaderEffect.crtLines().applicationKind == .layerEffect)
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
      .layerEffect,
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

  @Test("chromatic aberration sample offset follows channel separation and radial strength")
  func chromaticAberrationMaximumSampleOffset() {
    let effect = ShaderEffect.chromaticAberration(
      strength: 0.8,
      radialStrength: 5.8,
      channelSeparation: 1
    )

    let offset = effect.maximumSampleOffset(for: CGSize(width: 600, height: 300))

    expectApproximatelyEqual(Double(offset.width), 6.8)
    expectApproximatelyEqual(Double(offset.height), 6.8)
  }

  @Test("radial blur sample offset scales with the shortest side")
  func radialBlurMaximumSampleOffset() {
    let effect = ShaderEffect.radialBlur(
      origin: .zero,
      strength: 0.1,
      start: 0.95,
      end: 0.99,
      samples: 20
    )

    let offset = effect.maximumSampleOffset(for: CGSize(width: 600, height: 300))

    expectApproximatelyEqual(Double(offset.width), 15)
    expectApproximatelyEqual(Double(offset.height), 15)
  }

  @Test("CRT lines reserve enough offset to sample the centre of each source cell")
  func crtLinesMaximumSampleOffset() {
    let effect = ShaderEffect.crtLines(
      lineSpacing: 6,
      lineIntensity: 0.55,
      phosphorSize: 4,
      brightness: 1.35,
    )

    let offset = effect.maximumSampleOffset(for: .zero)

    expectApproximatelyEqual(Double(offset.width), 2)
    expectApproximatelyEqual(Double(offset.height), 3)
  }

  @Test("shader stack sample offset uses the largest contained effect offset")
  func shaderStackMaximumSampleOffset() {
    let effects: [ShaderEffect] = [
      .chromaticAberration(
        strength: 0.8,
        radialStrength: 5.8,
        channelSeparation: 1
      ),
      .radialBlur(
        origin: .zero,
        strength: 0.1,
        start: 0.95,
        end: 0.99,
        samples: 20
      ),
    ]

    let offset = ShaderEffect.maximumSampleOffset(
      for: effects,
      in: CGSize(width: 600, height: 300)
    )

    expectApproximatelyEqual(Double(offset.width), 15)
    expectApproximatelyEqual(Double(offset.height), 15)
  }
}
