//
//  ActionLinesView.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

//import BaseHelpers
import SwiftUI
import SharedHelpers

public struct ActionLinesView: View {

  #if canImport(AppKit)
  @Environment(\.modifierKeys) private var modifiers
  #endif
  @State var handler: ActionLineHandler = .init()

  @State var isDragging = false
  @State var lastDragPosition: CGPoint? = nil
  @State var currentPointOuter: CGPoint = .zero
  @State var currentPointInner: CGPoint = .zero

  @State var currentResizeInner: CGFloat = .zero

  @State private var displayText = "No gesture detected"

  let dampening: CGFloat = 1.2

  public init() {
  }

  public var body: some View {
    VStack {

      GeometryReader { proxy in
        CanvasView()
          .position(proxy.size.midpoint)
          .drawingGroup()
          #if canImport(AppKit)
        .gesture(
          dragGesture(in: proxy.size, with: modifiers)
        )
        .onTapGesture(count: 2) {
          if modifiers.contains(.option) {
            handler.lines.innerShape.position = nil
          } else {
            handler.lines.outerShape.position = nil
          }
        }
          #endif

        //        TrackpadGestureView { gestureType, state in
        //          switch gestureType {
        //            case .zoom:
        //              print("Zoom: \(state.total)")
        //            case .rotation:
        //              print("Rotation: \(state.total)")
        //            case .panX:
        //              print("Pan X: \(state.total)")
        //            case .panY:
        //              print("Pan Y: \(state.total)")
        //          }
        //        }
        //          .trackpadGestures { state in
        //
        //            print("Gesture state: \(state)")
        //            let updates = gestureHandler.handleGesture(state)
        //
        //            // Apply updates with animation if needed
        //            withAnimation(.interpolatingSpring(stiffness: 300, damping: 30)) {
        //            handler.lines.innerShape.radius = state.scaleEffect
        //            handler.lines.rotation = state.totalRotation
        //            handler.lines.radialCoverage = (state.scrollDeltaX)
        //            handler.lines.density = state.scrollDeltaY
        //            }
        //
        //            // Update display text
        //            self.displayText = """
        //                            Inner Radius: \(updates.innerRadius)
        //                            Rotation: \(updates.rotation)
        //                            Density: \(updates.density)
        //                            """
        //          }

        VStack {
          Button("Reset Zoom") {
            // Reset to default values
            handler.lines.innerShape.radius = 0.2
          }
          .padding()

          Text(displayText)
            .padding()
        }

        .frame(width: 300, height: 300)

        //        .trackpadGestures { state in
        //
        //          //            let currentInnerRadius = handler.lines.innerShape.radius
        //
        //          handler.lines.innerShape.radius = state.magnification
        //
        //          self.displayText = """
        //                Scroll X: \(state.scrollDeltaX)
        //                Scroll Y: \(state.scrollDeltaY)
        //                Zoom: \(state.magnification)
        //                Rotation: \(state.rotation)
        //                Phase: \(state.phase)
        //                """
        //        }
        //        .border(Color.green.opacity(0.3))

      }  // END geo reader
      .ignoresSafeArea()

      /// Controls
      ActionControlsView()
        .padding()
        .background(.black.opacityLow)

    }
  }
}

extension ActionLinesView {

  @ViewBuilder
  func CanvasView() -> some View {

    Canvas { context, size in

      // Get base variations
      let variations = handler.getVariations()

      // Process angles with current coverage and rotation
      let processedAngles = variations.processedAngles(
        coverage: handler.lines.radialCoverage,
        rotation: handler.lines.rotation
      )

      let outerCenter: CGPoint = handler.lines.outerShape.position ?? size.midpoint
      let innerCenter: CGPoint = handler.lines.innerShape.position ?? size.midpoint

      // Use variations.angles instead of generating them separately
      for (index, angle) in processedAngles.enumerated() {
        let distanceToBoundary: Double = ActionLineHandler.distanceToEdge(
          from: outerCenter,
          angle: angle,
          in: size,
          with: handler.lines.boundaryShape
        )

        // Use variations.boundaryInner[index] and variations.boundaryOuter[index]
        // for your variations instead of generating them separately

        let outerDistance = distanceToBoundary * handler.lines.outerShape.radius
        let outerPoint = CGPoint(
          x: outerCenter.x + cos(angle) * outerDistance,
          y: outerCenter.y + sin(angle) * outerDistance
        )

        let innerDistance = distanceToBoundary * handler.lines.innerShape.radius
        let baseInnerPoint = CGPoint(
          x: innerCenter.x + cos(angle) * innerDistance,
          y: innerCenter.y + sin(angle) * innerDistance
        )

        // Use cached variations
        let innerVariation = innerDistance * handler.lines.innerShape.variation * variations.boundaryInner[index]
        let actualInnerPoint = CGPoint(
          x: baseInnerPoint.x + cos(angle) * innerVariation,
          y: baseInnerPoint.y + sin(angle) * innerVariation
        )

        let outerVariation =
          (outerDistance - innerDistance) * handler.lines.outerShape.variation * variations.boundaryOuter[index]
        let actualOuterPoint = CGPoint(
          x: outerPoint.x + cos(angle) * outerVariation,
          y: outerPoint.y + sin(angle) * outerVariation
        )

        let trianglePath = ActionLineHandler.drawTrianglePath(
          from: actualInnerPoint,
          to: actualOuterPoint,
          in: context,
          style: handler.lines.lineStyle
        )
        context.fill(trianglePath, with: .color(handler.lines.lineStyle.color))

      }  // END loop over Angles

    }  // END canvas

  }  // END Canvas view builder

}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview {
  ActionLinesView()
}
#endif
