//
//  Waveforms.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/8/2025.
//

import BasePrimitives
//import LayoutKit
import SwiftUI
import VectorKit

/// Note: it's expected that this View will be embedded in a `TimelineView`,
/// to provide the `elapsed` time value.
public struct WaveView: View {
  @Environment(\.isEmphasised) private var isEmphasised
  @Environment(\.self) private var environment

  @State private var store = WaveHandler()

  let wave: Wave
  let elapsed: CGFloat
  let strokeWidth: CGFloat
  let sampleCount: Int
  let components: WaveComponents
  let waveViewStyle: WaveViewStyle

  public init(
    wave: Wave,
    elapsed: CGFloat,
    strokeWidth: CGFloat = 2,
    sampleCount: Int = 80,
    components: WaveComponents = [.all],
    waveViewStyle: WaveViewStyle = .standard,
  ) {
    self.wave = wave
    self.elapsed = elapsed
    self.strokeWidth = strokeWidth
    self.sampleCount = sampleCount
    self.components = components
    self.waveViewStyle = waveViewStyle
  }

  public var body: some View {

    Canvas {
      context,
      size in

      /// Ensure valid data before proceeding
      guard dataIsValid(size: size) else { return }

      /// Recompute static geometry only if needed
      if store.needsRecomputation(
        size: size,
        sampleCount: sampleCount
      ) {
        Task { @MainActor in
          store.recomputeStatic(
            for: size,
            wave: wave,
            sampleCount: sampleCount
          )
        }
      }

      /// Safety check: ensure arrays are properly initialized
      guard
        store.xPositions.count == sampleCount
          && store.spatialPhases.count == sampleCount
      else { return }

      /// Precompute frame-specific dynamic parts
      let omega = CGFloat.omega(frequency: wave.frequency.displayed)
      let amp = wave.amplitude.displayed

      /// Set up a Ghost phase only if required
      let phaseGhost: CGFloat? = isPhaseGhostRequired ? omega * elapsed : nil

      /// Ensure the main Wave's phase gets the offset, if present
      let phaseMain = omega * elapsed + wave.phaseOffset.displayed

      /// Generate main wave points
      let (mainPoints, ghostPoints) = store.generateWavePoints(
        normalPhase: phaseMain,
        ghostPhase: phaseGhost,
        amp: amp,
        viewHeight: size.height,
        sampleCount: sampleCount
      )

      /// Draw everything
      drawWaveComponents(
        context,
        in: size,
        mainPoints: mainPoints,
        ghostPoints: ghostPoints
      )

    }  // END canvas
    .frame(
      minHeight: 140,
      maxHeight: .infinity
    )
    .brightness(isViewBrightened ? 0.06 : 0)
    .opacity(isViewBrightened ? 1.0 : 0.82)
    .animation(Styles.animationSmoother, value: isViewBrightened)

    .background(isBackgroundBrightened ? Color.gray.opacity(0.01) : Color.clear)
    .animation(Styles.animationSpringQuickNSubtle, value: isBackgroundBrightened)

    .modifier(WaveEmphasisModifier(padding: store.emphasisPadding))

    .overlay(alignment: .topLeading) {
      EditingLabel()
        .padding(basePadding)
    }

    .overlay(alignment: .bottomLeading) {
      WaveInfoView(wave: wave)
        .padding(basePadding)
    }
    .onHover { hovering in
      store.isHovering = hovering
    }
  }
}
extension WaveView {

  private var clampedBaseLine: (thickness: CGFloat, gap: CGFloat) {
    let thickness = strokeWidth.clamped(1, 4)
    let gap = (strokeWidth * 1.3).clamped(2, 3)
    return (thickness, gap)
  }

  private var clampedPhaseLine: (thickness: CGFloat, gap: CGFloat) {
    let thickness = strokeWidth.clamped(1, 4)
    let gap = (strokeWidth * 1.3).clamped(2, 3)
    return (thickness, gap)
  }

  /// This is for a subtle brightness and opacity shift
  private var isViewBrightened: Bool { isEmphasised || store.isHovering }

  private var isBackgroundBrightened: Bool { isEmphasised || store.isHovering }

  var isPhaseGhostRequired: Bool { wave.phaseOffset.displayed != 0 }

  private func drawWaveComponents(
    _ context: GraphicsContext,
    in size: CGSize,
    mainPoints: [CGPoint],
    ghostPoints: [CGPoint]?,
  ) {
    /// Draw base line first (underneath)
    context.dashedStroke(
      store.baseLinePath,
      colour: .gray.opacity(0.2),
      strokeWidth: clampedBaseLine.thickness,
      gap: clampedBaseLine.gap
    )

    /// Ghost line
    if wave.phaseOffset.displayed > 0,
      components.contains(.phaseGhost),
      let ghostPoints
    {
      drawGhostPhaseWave(context: context, points: ghostPoints, in: size)
    }

    /// Main wave line
    if components.contains(.line) {
      drawMainWave(context: context, points: mainPoints, in: size)
    }

    /// Points
    if components.contains(.points) {
      drawWavePoints(context: context, points: mainPoints, in: size)
    }
  }

  private var basePadding: CGFloat {
    //    let base = Styles.sizeSmall
    return Styles.sizeRegular.bump
    //    return isEmphasised ? base + emphasisPadding : base

  }

  private var dotRadius: CGFloat {
    max(2, strokeWidth * 1.4)
    //    max(2, adjustedStrokeWidth * 1.4)
  }

  private func dataIsValid(size: CGSize) -> Bool {
    return size.width > 0
      && size.height > 0
      && sampleCount > 0
  }

  private func drawMainWave(
    context: GraphicsContext,
    points: [CGPoint],
    in size: CGSize
  ) {
    guard points.count > 1 else { return }

    var linePath = Path()
    linePath.addLines(points)
    context.stroke(
      linePath,
      with: .color(.pink),
//      with: .color(wave.colour.swiftUIColour),
      lineWidth: strokeWidth
    )
  }

  private func drawWavePoints(
    context: GraphicsContext,
    points: [CGPoint],
    in size: CGSize
  ) {

    let dot = Path(
      ellipseIn: CGRect(
        x: -dotRadius,
        y: -dotRadius,
        width: dotRadius * 2,
        height: dotRadius * 2
      ))

    for point in points {
      //    for point in points.dropFirst().dropLast() {
      var pointContext = context
      pointContext.translateBy(x: point.x, y: point.y)
      pointContext.fill(dot, with: .color(.brown))
    }
  }

  //  private var lineColour: Color {
  //    let bright = wave.colour.swiftUIColour.contrastColour(
  //      strength: .moderate,
  //      purpose: .complimentary,
  //      chroma: .standard,
  //      environment: environment
  //    )
  //    let regular = wave.colour.swiftUIColour
  //
  //    return isViewBrightened ? bright : regular
  //  }
  private var phaseColour: Color { Color.accentColor }

  //  private var phaseColour: Color {
  //    wave.colour.swiftUIColour.contrastColour(
  //      strength: .highContrast,
  //      purpose: .complimentary,
  //      chroma: .standard,
  //      environment: environment
  //    )
  //  }

  private func drawGhostPhaseWave(
    context: GraphicsContext,
    points: [CGPoint],
    in size: CGSize
  ) {
    guard points.count > 1 else { return }

    var ghostPath = Path()
    ghostPath.addLines(points)

    context.dashedStroke(
      ghostPath,
      colour: phaseColour.opacityMid,
      strokeWidth: clampedPhaseLine.thickness,
      style: .dashes(length: strokeWidth),
      gap: clampedPhaseLine.gap
    )
  }

  //  private var widthExpandFactor: CGFloat { 1.4 }
}

extension Path {
  /// This is stretching *from the centre*
  func stretchHorizontally(by factor: CGFloat, in size: CGSize) -> Path {
    let scaleX = factor
    let offsetX = -(size.width * (scaleX - 1) / 2)

    let newPath =
      self
      .applying(.init(scaleX: scaleX, y: 1))
      .applying(.init(translationX: offsetX, y: 0))
    return newPath

  }
}
