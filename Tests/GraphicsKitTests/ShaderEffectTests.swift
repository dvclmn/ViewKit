import CoreGraphics
import Foundation
import Testing
@testable import GraphicsKit

struct ShaderEffectTests {

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

  @Test("chromatic aberration decodes legacy payloads")
  func chromaticAberrationDecodesLegacyPayloads() throws {
    let data = Data(
      #"""
      {
        "chromaticAberration": {
          "strength": 0.8,
          "radialStrength": 5.8
        }
      }
      """#.utf8
    )

    let effect = try JSONDecoder().decode(ShaderEffect.self, from: data)

    guard
      case .chromaticAberration(
        let strength,
        let radialStrength,
        let channelSeparation
      ) = effect
    else {
      #expect(Bool(false))
      return
    }

    expectApproximatelyEqual(Double(strength), 0.8)
    expectApproximatelyEqual(Double(radialStrength), 5.8)
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
