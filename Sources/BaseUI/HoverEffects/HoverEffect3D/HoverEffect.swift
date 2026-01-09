//
//  HoverEffect.swift
//  Collection
//
//  Created by Dave Coleman on 12/11/2024.
//

import SharedHelpers
import SwiftUI

public typealias Hover3DOutput = (Hover3DState) -> Void


public struct Hover3DModifier: ViewModifier {

  @State var isHovering: Bool = false
  @State var hoverPoint: CGPoint = .zero

  @State private var viewSize: CGSize = .zero

  let rounding: CGFloat
  let glintStrength: CGFloat
  let depthStrength: CGFloat
  let onUpdate: Hover3DOutput

  public func body(content: Content) -> some View {
    content
      .viewSize(mode: .debounce(0.2)) { size in
        viewSize = size
      }
      .overlay {
        GlintEffect()
      }
      .clipShape(.rect(cornerRadius: rounding))
      .rotation3DEffect(
        Angle(degrees: calculateRotationAngle(depthStrength)),
        axis: (
          x: funAngle(.horizontal),
          y: funAngle(.vertical),
          z: 0
        ),
        anchor: .center,
        anchorZ: 0
      )
      .onContinuousHover { phase in
        withAnimation(Styles.animationSpringSubtle) {
          switch phase {
            case .active(let point):
              isHovering = true
              hoverPoint = point
              sendHoverUpdate()
            case .ended:
              isHovering = false
              hoverPoint = viewSize.midpoint  // Reset to center
              sendHoverUpdate()
          }
        }
      }
  }
}


extension Hover3DModifier {

  private func sendHoverUpdate() {
    guard viewSize.isGreaterThanOrEqualToZero else { return }

    let normalised = setAnchorToMiddle(hoverPoint)
    let distance = sqrt(normalised.x * normalised.x + normalised.y * normalised.y)
    let rotation = calculateRotationAngle(depthStrength)

    onUpdate(
      Hover3DState(
        normalisedPoint: normalised,
        hoverPoint: hoverPoint,
        distanceFromCentre: distance,
        rotationAngle: rotation
      )
    )
  }

  @ViewBuilder
  func GlintEffect() -> some View {
    if isHovering {
      Rectangle()
        .fill()
        .frame(width: 10, height: viewSize.height * 1.5)
        .rotationEffect(.degrees(30))
        .blur(radius: 26)
        .frame(width: 10)
        .position(glintPosition)
        .opacity(glintStrength)
    }
  }

  private var glintPosition: CGPoint {
    let posX = hoverPoint.stretchedPosition(.horizontal, in: viewSize, stretchFactor: 1.8)
    let baseY = viewSize.height / 2
    let hoverYReduced = hoverPoint.y * 0.2
    let posY = baseY + hoverYReduced

    return CGPoint(x: posX, y: posY)
  }

  private func calculateRotationAngle(_ strength: Double) -> Double {
    guard isHovering else { return 0 }

    let normalisedPoint = setAnchorToMiddle(hoverPoint)

    /// Calculate the distance from center to determine rotation intensity
    let distance = sqrt(pow(normalisedPoint.x, 2) + pow(normalisedPoint.y, 2))

    /// Scale the angle based on distance from center
    return distance * depthStrength
  }

  private func funAngle(_ axis: Axis) -> CGFloat {
    guard isHovering else { return .zero }

    let normalisedPoint = setAnchorToMiddle(hoverPoint)

    switch axis {
      case .horizontal:
        /// Inverted `x` to match natural movement
        return -normalisedPoint.y
      case .vertical:
        return normalisedPoint.x
    }
  }

  private func setAnchorToMiddle(_ point: CGPoint) -> CGPoint {

    /// Convert from top-left origin to center origin by subtracting half the view size
    /// This will result in values from -1 to 1 relative to the center

    guard viewSize.isGreaterThanOrEqualToZero else { return .zero }

    let halfWidth = viewSize.width / 2

    let normalisedX = (point.x - halfWidth) / halfWidth
    let normalisedY = (point.y - halfWidth) / halfWidth

    return CGPoint(x: normalisedX, y: normalisedY)
  }

  @ViewBuilder
  private func HoverDebugText() -> some View {
    VStack {
      Text("X: \(setAnchorToMiddle(hoverPoint).x.displayString)")
      Text("Y:\(setAnchorToMiddle(hoverPoint).y.displayString)")
      Text("Width: \(viewSize.width.displayString)")
      Text("Height: \(viewSize.height.displayString)")
    }
    .font(.callout)
    .padding(4)
    .monospacedDigit()
    .background(.black.opacity(0.6))
  }
}


extension View {
  public func hover3DEffect(
    rounding: CGFloat = Styles.sizeSmall,
    glintStrength: CGFloat = 0.3,
    depthStrength: CGFloat = 8,
    onUpdate: @escaping Hover3DOutput = { _ in }
  ) -> some View {
    self.modifier(
      Hover3DModifier(
        rounding: rounding,
        glintStrength: glintStrength,
        depthStrength: depthStrength,
        onUpdate: onUpdate
      )
    )
  }
}
