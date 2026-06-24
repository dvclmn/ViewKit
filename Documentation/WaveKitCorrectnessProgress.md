# WaveKit correctness progress

Date: 24 June 2026

## Why the original tests were green

The green result was real, but narrower than the overall claim that “WaveKit is
correct”. The phase and waveform tests exercise pure primitives: conversion,
wrapping, waveform landmarks, periodicity, range, and lookup-table agreement.
The implementation they exercise had already been changed so that `UnitPhase`
wraps on initialisation. In other words, some of the tests and their repair
arrived together; they are regression protection for that repaired contract,
not evidence that the earlier implementation happened to be correct.

They also did not exercise the live `BreathingLoop`. That renderer independently
combined temporal and spatial radians with a static offset in turns, then called
`sin` directly. A correct `WaveSampler` cannot protect a caller that bypasses it.

The WaveKit target split exposed one more gap: two phase test files still
imported `GraphicsKit`, and the test target did not directly depend on `WaveKit`.
The tests now import and depend on the module that owns the symbols.

## Implemented in BaseHelpers

- `ConfiguredWave.sample(at:elapsed:)` is now the authoritative configured-wave
  evaluator. Frequency × elapsed time, configured cycles × normalised index,
  and static phase offset are all composed in turns.
- `WaveSampler` remains the only waveform-shape boundary and owns wrapping via
  `UnitPhase`; amplitude is applied after unit sampling.
- Batch sampling now delegates to the scalar API.
- The formerly trapping `sampleTurns` and `samples(indices:time:)` APIs now
  forward safely and are deprecated in favour of the explicit API.
- The ambiguous renderer helper `timePhase(from:)` and `sampleAlt` are retained
  as deprecated source-compatible APIs rather than being removed from a public
  Swift package without a migration path.
- `WaveDocument` now owns `addElement`, `removeElement`, and `removeWave`.
  Element removal deletes a newly orphaned wave but preserves a wave that is
  still shared by another driver. Wave removal also removes its drivers.
- `WaveDocument.validationIssues` reports dangling drivers and unreferenced
  waves; `isValid` provides the simple gate.
- The old `baseValue:` addition overload is retained but deprecated. The value
  was never stored, and the current renderer derives bases from element kind,
  render settings, view geometry, and sample index. Adding a second source of
  base values requires an explicit model decision rather than silently ignoring
  the argument.

## Verification

Twenty-one focused Swift Testing tests pass across five suites:

- unit phase;
- phase conversion;
- waveform sampling;
- configured-wave sampling; and
- document integrity.

The tests were run with a temporary local SwiftPM override for ToolKit. The
declared remote ToolKit `0.2.0` does not currently export `ColourTools`, so a
clean remote-only package resolution fails before compilation. The override was
removed after verification.

## Remaining integration work

The sibling BaseDemos package still needs these narrow migrations:

1. Make `BreathingLoop.offset(from:index:)` return
   `wave.sample(at: index, elapsed: elapsedTime)` and remove its direct phase
   arithmetic and `sin` call.
2. In `computeSampleElements`, use `continue` rather than `break` for a dangling
   driver so one bad relationship does not suppress every later driver.
3. Make `ElementPicker` call `WaveDocument.removeElement(_:)`.
4. Make the inspector call `WaveDocument.removeWave(id:)`.
5. Decide whether superseded previews/caches should be migrated to the same
   boundary or quarantined. `WaveformEngine.buildWavePath` and
   `WaveformPicker` still contain direct sine generation; the legacy views also
   expose phase in radians even though authored phase is now turns-first.
6. Resolve settings that remain advertised but unused, especially
   `WaveConfig.noise` and `WaveRenderSettings.blendMode`. These require explicit
   deterministic-noise and multi-driver composition semantics; silently folding
   them into the new pure sampler would make its contract ambiguous again.

The strongest next integration test is not another `WaveSampler` formula test.
It is a renderer/document test proving that a quarter-turn static offset is a
quarter cycle in the active loop, every waveform reaches the render path, and a
dangling driver cannot prevent later drivers from being evaluated.
