//
//  CurveVisualisationView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 26/8/2025.
//

import BaseComponents
import BaseHelpers
import CurveFunctions
import SwiftUI

public struct CurveFunctionView: View {
  @Environment(\.self) private var envSelf
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.explicitWidth) private var explicitWidth

  let steps: Int
  let inputRange: ClosedRange<CGFloat>
  let outputRange: ClosedRange<CGFloat>
  let curve: CurveFunction
  let ease: EaseDirection
  let strength: CGFloat
  let colour: CodableColour
  let components: CurveVisualComponent

  private let numbersHeight: CGFloat = Styles.sizeMedium

  public init(
    steps: Int = 12,
    inputRange: ClosedRange<CGFloat>,
    outputRange: ClosedRange<CGFloat>,
    curve: CurveFunction = .cubic,
    ease: EaseDirection = .in,
    strength: CGFloat = 1.8,
    colour: CodableColour,
    components: CurveVisualComponent = .all
  ) {
    self.steps = steps
    self.inputRange = inputRange
    self.outputRange = outputRange
    self.curve = curve
    self.ease = ease
    self.strength = strength
    self.colour = colour
    self.components = components
  }

  public var body: some View {

    VStack(alignment: .leading, spacing: Styles.sizeRegular) {
      if components.contains(.bars) {
        Bars()
          .padding(.bottom, numbersHeight)
      }

      if components.contains(.labels) {
        CurveLabels()
      }

    }
    .frame(maxWidth: .infinity)
  }
}

extension CurveFunctionView {

  @ViewBuilder
  func CurveLabels() -> some View {

    FlowLayout(alignment: .leading) {

      //      HStack {
      ForEach(CurveInfo.allCases) { curveInfo in

        switch curveInfo {
          case .curve:
            Text(curve.rawValue)

          case .ease:
            Text(ease.name)

          case .steps:
            Text("\(steps) Steps")

          case .minMax:
            Text("\(minHeight.displayString(places: 0)) to \(maxHeight.displayString(places: 0))")
        //            case .maxValue:
        //              Text("\(steps) Steps")
        }

      }  // END foreach
      .foregroundStyle(.secondary)
      .font(.caption.monospaced())
      //      .padding(.horizontal, Styles.sizeMicro)
      .padding(.horizontal, barSpacing * 0.4)
      .quickBackground(rounding: Styles.sizeTiny)
      .environment(\.layoutSpacing, 2)
    }
  }

  var barSpacing: CGFloat { layoutSpacing ?? 12 }
  var barWidth: CGFloat { explicitWidth ?? 18 }

  private func contrast(_ strength: CGFloat) -> Color {
    colour.contrastColour(
      strength: .custom(strength),
      purpose: .complementary,
      chroma: .standard,
      environment: envSelf
    ).colour
  }

  @ViewBuilder
  func Bars() -> some View {
    HStack(alignment: .bottom, spacing: .zero) {
      ForEach(Array(curveSamples.enumerated()), id: \.element) { index, height in
        SingleBar(height, index: index)
      }
    }
    .overlay {
      if components.contains(.line) {
        LineGraphView(
          samples: curveSamples,
          barSpacing: barSpacing,
          barWidth: barWidth,
          colour: colour
        )
      }
    }
  }

  private var fontSize: CGFloat {
    let base = barWidth * 0.9
    return base
  }

  @ViewBuilder
  func SingleBar(_ step: CGFloat, index: Int) -> some View {
    RoundedRectangle(cornerRadius: Styles.sizeNano)
      .fill(contrast(step * 0.006))
      .frame(
        width: barWidth,
        height: step
      )
      .padding(.horizontal, barSpacing / 2)

      .overlay(alignment: .bottom) {
        BarText(step, index: index)
      }
  }

  @ViewBuilder
  func BarText(_ step: CGFloat, index: Int) -> some View {
    if components.contains(.barNumbers) {
      Text((index + 1).toString)
        .foregroundStyle(.secondary)
    }

    if components.contains(.values) {
      Text(step.displayString(places: 0))
        .font(.system(size: fontSize, weight: numbersWeight(step)))
        .foregroundStyle(numbersColour(step))
        //          .monospacedDigit()
        .lineLimit(1)
        .offset(y: numbersHeight)
    }
  }

  private func numbersColour(_ step: CGFloat) -> Color {
    isEndCap(step) ? Color.primary : Color.secondary
  }
  private func numbersWeight(_ step: CGFloat) -> Font.Weight {
    isEndCap(step) ? .semibold : .regular
  }
  private func isEndCap(_ step: CGFloat) -> Bool {
    return [minHeight, maxHeight].contains(step)
  }

  private func mapped(_ step: CGFloat) -> CGFloat {
    step.mappedNonLinearly(
      from: inputRange,
      to: outputRange,
      curve: curve,
      ease: ease
    ) * strength
  }

  private var minMaxAndValues: (min: CGFloat, max: CGFloat, values: [CGFloat]) {
    var minValue = CGFloat.greatestFiniteMagnitude
    var maxValue = -CGFloat.greatestFiniteMagnitude
    var results: [CGFloat] = []

    for x in inputRange.split(into: steps) {
      let height = mapped(x)
      results.append(height)
      minValue = min(minValue, height)
      maxValue = max(maxValue, height)
    }

    return (minValue, maxValue, results)
  }

  private var minHeight: CGFloat { minMaxAndValues.min }
  private var maxHeight: CGFloat { minMaxAndValues.max }
  private var curveSamples: [CGFloat] { minMaxAndValues.values }

}

enum CurveInfo: String, Identifiable, CaseIterable {
  case curve
  case ease
  case steps
  case minMax

  var id: String { rawValue }

}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview {
  @Previewable @State var envSelf = EnvironmentValues()
  CurveFunctionView(
    inputRange: 1...0,
    outputRange: 10...20,
    colour: Color.blue.toCodable(envSelf)
  )
  .environment(\.self, envSelf)
}
#endif

public struct CurveVisualComponent: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let values = Self(rawValue: 1 << 0)
  public static let bars = Self(rawValue: 1 << 1)
  public static let barNumbers = Self(rawValue: 1 << 2)
  public static let line = Self(rawValue: 1 << 3)
  public static let labels = Self(rawValue: 1 << 4)

  public static let all: Self = [.values, .bars, .line, .barNumbers, .labels]
}
