import WaveKit
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

  /// This range exercises eight complete turns, including raw negative phases.
  /// It concerns unit waveform output only; amplitude is applied by the
  /// `ConfiguredWave` evaluation layer.
  @Test("Unit samples remain in range", arguments: Waveform.allCases)
  func unitSamplesRemainInRange(_ waveform: Waveform) {
    for step in -256...256 {
      let phase = Double(step) / 64
      let value = WaveSampler<Double>.sample(waveform, phase: phase)

      #expect((-1.0...1.0).contains(value))
    }
  }

  /// This grid lands on every sixteenth lookup-table entry. It establishes
  /// that the stored table values describe the same sine as the mathematical
  /// implementation over both negative and positive turns.
  @Test("Mathematical and lookup sine agree")
  func sineModesAgree() {
    for step in -512...512 {
      let phase = Double(step) / 128
      let mathematical = WaveSampler<Double>.sample(
        .sine(mode: .math),
        phase: phase
      )
      let lookup = WaveSampler<Double>.sample(
        .sine(mode: .table),
        phase: phase
      )

      expectApproximatelyEqual(
        lookup,
        mathematical,
        tolerance: 1e-5
      )
    }
  }

  /// Sampling halfway between each pair of table entries exercises the linear
  /// interpolation path, where lookup error is expected to be greatest. For
  /// the 2,048-entry table, the measured maximum error is approximately
  /// `1.177e-6`; the `1e-5` tolerance leaves a deliberate numerical margin.
  @Test("Lookup sine interpolation agrees with mathematical sine")
  func sineLookupInterpolationAgrees() {
    let tableSize = 2_048

    for step in -tableSize...tableSize {
      let phase = (Double(step) + 0.5) / Double(tableSize)
      let mathematical = WaveSampler<Double>.sample(
        .sine(mode: .math),
        phase: phase
      )
      let lookup = WaveSampler<Double>.sample(
        .sine(mode: .table),
        phase: phase
      )

      expectApproximatelyEqual(
        lookup,
        mathematical,
        tolerance: 1e-5
      )
    }
  }
}
