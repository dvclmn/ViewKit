import Foundation
import Testing
import WaveKit

@Suite("Configured wave sampling")
struct ConfiguredWaveSamplingTests {

  @Test("Static phase offset is interpreted in turns")
  func staticPhaseOffsetUsesTurns() {
    let wave = ConfiguredWave(
      amplitude: 3,
      frequency: 0,
      phaseOffset: 0.25,
      waveform: .sine(mode: .math),
      cycles: 0
    )

    expectApproximatelyEqual(
      wave.sample(at: 0, elapsed: 0),
      3,
      tolerance: 1e-12
    )
  }

  @Test("Temporal, spatial, and static phase compose in turns")
  func phaseComponentsComposeInTurns() {
    let wave = ConfiguredWave(
      amplitude: 2,
      frequency: 0.5,
      phaseOffset: 0.125,
      waveform: .sine(mode: .math),
      cycles: 2
    )

    // 0.125 temporal + 0.5 spatial + 0.125 static = 0.75 turns.
    expectApproximatelyEqual(
      wave.sample(at: 0.25, elapsed: 0.25),
      -2,
      tolerance: 1e-12
    )
  }

  @Test(
    "Configured evaluation delegates every waveform to WaveSampler",
    arguments: Waveform.allCases
  )
  func evaluationDelegatesToSampler(_ waveform: Waveform) {
    let wave = ConfiguredWave(
      amplitude: 2.5,
      frequency: 0.75,
      phaseOffset: -0.2,
      waveform: waveform,
      cycles: 1.25
    )
    let index = 0.6
    let elapsed = 1.4
    let phaseTurns = 0.75 * elapsed + 1.25 * index - 0.2
    let expected = 2.5 * WaveSampler<Double>.sample(waveform, phase: phaseTurns)

    expectApproximatelyEqual(
      wave.sample(at: index, elapsed: elapsed),
      expected,
      tolerance: 1e-12
    )
  }

  @Test("Batch evaluation matches scalar evaluation")
  func batchEvaluationMatchesScalarEvaluation() {
    let wave = ConfiguredWave(
      amplitude: 4,
      frequency: 0.3,
      phaseOffset: 0.1,
      waveform: .triangle,
      cycles: 3
    )
    let indices = [-0.25, 0, 0.2, 0.75, 1.5]
    let elapsed = 2.25

    let expected = indices.map { wave.sample(at: $0, elapsed: elapsed) }

    #expect(wave.samples(at: indices, elapsed: elapsed) == expected)
  }
}
