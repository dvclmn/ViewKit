//
//  Model+Waveform.swift
//  Moving shapes
//
//  Created by Dave Coleman on 28/1/2025.
//

//
//import SwiftUI

// Enhanced WaveformGenerator with phase offset support
protocol WaveformGenerator {
  func getValue(at time: Double, frequency: Double, amplitude: Double, phaseOffset: Double) -> Double
}

// More sophisticated waveform implementations
struct SineWave: WaveformGenerator {
  func getValue(at time: Double, frequency: Double, amplitude: Double, phaseOffset: Double) -> Double {
    // time * frequency determines how many cycles per second
    // phaseOffset lets us shift the wave left/right
    amplitude * sin(2 * .pi * (frequency * time + phaseOffset))
  }
}

struct TriangleWave: WaveformGenerator {
  func getValue(at time: Double, frequency: Double, amplitude: Double, phaseOffset: Double) -> Double {
    // Convert sine wave to triangle using asin
    amplitude * (2 / .pi) * asin(sin(2 * .pi * (frequency * time + phaseOffset)))
  }
}

struct SquareWave: WaveformGenerator {
  func getValue(at time: Double, frequency: Double, amplitude: Double, phaseOffset: Double) -> Double {
    let value = sin(2 * .pi * (frequency * time + phaseOffset))
    return amplitude * (value >= 0 ? 1 : -1)
  }
}

// Enhanced LFO with phase
struct LFO {
  var waveform: WaveformGenerator
  var frequency: Double
  var amplitude: Double
  var phaseOffset: Double = 0

  func getValue(at time: Double) -> Double {
    waveform.getValue(
      at: time,
      frequency: frequency,
      amplitude: amplitude,
      phaseOffset: phaseOffset)
  }
}

// ADSR Envelope for shape parameters
struct Envelope {
  var attack: Double
  var decay: Double
  var sustain: Double
  var release: Double

  func getValue(at time: Double, triggered: Bool) -> Double {
    // Basic ADSR implementation
    if !triggered { return 0 }

    if time < attack {
      return time / attack
    } else if time < attack + decay {
      let decayProgress = (time - attack) / decay
      return 1.0 - (1.0 - sustain) * decayProgress
    } else {
      return sustain
    }
  }
}

// Enhanced wave layer with smoothed parameters
struct AnimatedWaveformLayer: Identifiable {
  var id: UUID = UUID()
  private var baseWaveform: WaveformGenerator
  private var smoothedFrequency: SmoothedParameter
  private var smoothedPhase: SmoothedParameter
  private var smoothedAmplitude: SmoothedParameter
  private var lastUpdateTime: Double?

  var lfo: LFO?
  var startColor: Color
  var endColor: Color

  var frequency: Double {
    didSet {
      smoothedFrequency.setTarget(frequency)
    }
  }

  var phaseOffset: Double {
    didSet {
      smoothedPhase.setTarget(phaseOffset)
    }
  }

  var amplitude: Double {
    didSet {
      smoothedAmplitude.setTarget(amplitude)
    }
  }

  init(
    baseWaveform: WaveformGenerator,
    frequency: Double = 1.0,
    amplitude: Double = 1.0,
    phaseOffset: Double = 0.0,
    lfo: LFO? = LFO(
      waveform: SineWave(),
      frequency: 0.3,
      amplitude: 0.2,
      phaseOffset: 0.8
    ),
    startColor: Color = .green,
    endColor: Color = .purple
  ) {
    self.baseWaveform = baseWaveform
    self.frequency = frequency
    self.amplitude = amplitude
    self.phaseOffset = phaseOffset

    // Initialize smoothed parameters
    self.smoothedFrequency = SmoothedParameter(initialValue: frequency, smoothingFactor: 0.95)
    self.smoothedPhase = SmoothedParameter(initialValue: phaseOffset, smoothingFactor: 0.95)
    self.smoothedAmplitude = SmoothedParameter(initialValue: amplitude, smoothingFactor: 0.8)

    self.lfo = lfo
    self.startColor = startColor
    self.endColor = endColor

  }

  mutating func update(at currentTime: Double) {
    if let lastTime = lastUpdateTime {
      let deltaTime = currentTime - lastTime
      smoothedFrequency.update(deltaTime: deltaTime)
      smoothedPhase.update(deltaTime: deltaTime)
      smoothedAmplitude.update(deltaTime: deltaTime)
    }
    lastUpdateTime = currentTime
  }

  mutating func getPointsAlongPath(time: Double, size: CGSize, resolution: Int = 100) -> [(CGPoint, Double)] {
    var points: [(CGPoint, Double)] = []

    // Update smoothed parameters
    update(at: time)

    for i in 0..<resolution {
      let progress = Double(i) / Double(resolution - 1)
      let x = progress * size.width

      // Use smoothed parameters for calculations
      let y = baseWaveform.getValue(
        at: time,
        frequency: smoothedFrequency.value,
        amplitude: smoothedAmplitude.value,
        phaseOffset: smoothedPhase.value + progress
      )

      let point = CGPoint(
        x: x,
        y: size.height / 2 + CGFloat(y) * size.height / 3
      )

      points.append((point, progress))
    }

    return points
  }
}
