//
//  ShadowExamples.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import SwiftUI

private struct ShadowExampleView: View {

  private let totalBackgroundShapes: Int = 10

  var body: some View {

    VStack(spacing: 90) {

      BaseView("Depth effect ON")
        .quickShadow(
          opacity: 0.9,
          radius: 16,
          distanceY: 40,
          depth: ShadowDepth(rounding: 20, distance: 0.9)
        )

      BaseView("Depth effect OFF")
        .quickShadow(
          opacity: 0.9,
          radius: 16,
          distanceY: 40,
        )

      //      RoundedRectangle(cornerRadius: 20)
      //        .fill(.ultraThinMaterial)
      //        .aspectRatio(3.1, contentMode: .fit)
      //        .frame(width: 380)
      //        .overlay {
      //          Text("Opacity Zero")
      //            .font(.system(size: 15, weight: .medium))
      //        }
      //        .quickShadow(
      //          opacity: 0.0, radius: 16, distanceY: 40, depth: ShadowDepth(rounding: 20, distance: 0.9))
      //
      //      RoundedRectangle(cornerRadius: 20)
      //        .fill(.ultraThinMaterial)
      //        .aspectRatio(3.1, contentMode: .fit)
      //        .frame(width: 380)
      //        .overlay {
      //          Text("Depth effect ON")
      //            .font(.system(size: 15, weight: .medium))
      //        }
      //        .quickShadow(
      //          opacity: 0.9, radius: 16, distanceY: 40, depth: ShadowDepth(rounding: 20, distance: 0.9)
      //        )
      //
      //        .padding(.bottom, 40)
      //
      //      RoundedRectangle(cornerRadius: 20)
      //        .fill(.ultraThinMaterial)
      ////        .fill(.gray)
      //        .aspectRatio(3.1, contentMode: .fit)
      //        .frame(width: 380)
      //        .quickShadow(opacity: 0.7, radius: 16, distanceY: 50)
      //        .overlay {
      //          Text("Depth effect OFF")
      //            .font(.system(size: 15, weight: .medium))
      //        }

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(38)
    .background {
      ForEach(0..<totalBackgroundShapes, id: \.self) { item in
        Rectangle()
          .fill(shapeColour(item))
          .frame(width: 30, height: 800)
          .rotationEffect(
            .degrees(CGFloat(item) * (360.0 / CGFloat(totalBackgroundShapes))),
            anchor: rotationAnchor(item)
          )
      }
    }
    .background(.teal.opacity(0.2))

  }
}

extension ShadowExampleView {

  @ViewBuilder
  private func BaseView(_ label: String) -> some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(.ultraThinMaterial)
      //        .fill(.gray)
      .aspectRatio(3.1, contentMode: .fit)
      .frame(width: 380)
      .overlay {
        Text(label)
          .font(.system(size: 15, weight: .medium))
      }
  }

  private func shapeColour(_ index: Int) -> Color {
    let indexFloat = CGFloat(index)

    let colour = Color(hue: indexFloat, saturation: 1.0 * (indexFloat * 0.5), brightness: 0.6)
    return colour
    //    .init(hue: 0.6 + (Double(index) * 0.05), saturation: 0.8, brightness: 0.9)
  }

  private func rotationAnchor(_ index: Int) -> UnitPoint {
    let indexFloat = CGFloat(index)
    return UnitPoint(
      x: 0.3 - (indexFloat * 0.11),
      y: 0.7 - (indexFloat * 0.05))

  }
}

#if DEBUG
#Preview {
  ShadowExampleView()
    .frame(width: 600, height: 700)
}
#endif
