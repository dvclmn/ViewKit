import GraphicsKit
import Testing

@Suite("Waveform sampling")
struct WaveformSamplingTests {

  struct Landmark: Sendable {
    let phase: Double
    let sine: Double
    let triangle: Double
    let sawtooth: Double
    let square: Double
  }

  /// These fixed landmarks are independent reference values for each formula.
  /// In particular, they specify the intended values at the discontinuities.
  @Test(
    "Waveforms pass through their unit landmarks",
    arguments: [
      Landmark(phase: 0.0, sine: 0.0, triangle: -1.0, sawtooth: -1.0, square: 1.0),
      Landmark(phase: 0.25, sine: 1.0, triangle: 0.0, sawtooth: -0.5, square: 1.0),
      Landmark(phase: 0.5, sine: 0.0, triangle: 1.0, sawtooth: 0.0, square: -1.0),
      Landmark(phase: 0.75, sine: -1.0, triangle: 0.0, sawtooth: 0.5, square: -1.0),
      Landmark(phase: 1.0, sine: 0.0, triangle: -1.0, sawtooth: -1.0, square: 1.0),
    ],
  )
  func waveformLandmarks(_ landmark: Landmark) {
    let phase = UnitPhase<Double>(landmark.phase)

    expectApproximatelyEqual(
      WaveSampler<Double>.sample(.sine(mode: .math), phase: phase),
      landmark.sine
    )
    expectApproximatelyEqual(
      WaveSampler<Double>.sample(.sine(mode: .table), phase: phase),
      landmark.sine
    )
    expectApproximatelyEqual(
      WaveSampler<Double>.sample(.triangle, phase: phase),
      landmark.triangle
    )
    expectApproximatelyEqual(
      WaveSampler<Double>.sample(.sawtooth, phase: phase),
      landmark.sawtooth
    )
    expectApproximatelyEqual(
      WaveSampler<Double>.sample(.square, phase: phase),
      landmark.square
    )
  }

  /// Periodicity is a property rather than a collection of special values:
  /// adding or removing whole turns must not change the sampled position.
  @Test("Every waveform is periodic", arguments: Waveform.allCases)
  func everyWaveformIsPeriodic(_ waveform: Waveform) {
    let phases = [0.0, 0.125, 0.25, 0.6, 0.875]
    let offsets = [-4.0, -1.0, 0.0, 1.0, 3.0]

    for phase in phases {
      let expected = WaveSampler<Double>.sample(waveform, phase: phase)

      for offset in offsets {
        let actual = WaveSampler<Double>.sample(
          waveform,
          phase: phase + offset
        )

        expectApproximatelyEqual(actual, expected, tolerance: 1e-8)
      }
    }
  }
}
