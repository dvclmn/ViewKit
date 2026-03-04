//
//  GridGuideView.swift
//  SumBuddy
//
//  Created by Dave Coleman on 11/10/2025.
//

//import CoreTools
//import GraphicsKit
//import SwiftUI
//
//public struct GridGuideOverlayModifier: ViewModifier {
//  @Environment(\.activeUnitSize) private var activeUnitSize
//  @Environment(\.gridDimensions) private var gridDimensions
//  @Environment(\.layoutAlignment) private var layoutAlignment
//
//  private let isDrawingDebugText: Bool = false
//
//  let opacity: CGFloat
//  let isEnabled: Bool
//
//  public func body(content: Content) -> some View {
//    content
//      .overlay {
//        if isEnabled {
//          GridGuide()
//            .allowsHitTesting(false)
//        }  // is showing check
//      }  // END overlay
//  }
//}
//
//extension GridGuideOverlayModifier {
//
//  //  private var screenSize: FrameDimensions {
//  ////    guard let unitSize, let gridDimensions else { return nil }
//  ////    let w = gridDimensions.width.toScreenLength(using: unitSize.width)
//  ////    let h = gridDimensions.height.toScreenLength(using: unitSize.height)
//  ////    return FrameDimensions(width: w, height: h)
//  //    //    private var screenWidth: CGFloat? {
//  //    //      guard let unitWidth = characterSize?.width else { return nil }
//  //    //      return columnWidth.toScreenLength(using: unitWidth)
//  //    //    }
//  //  }
//  @ViewBuilder
//  private func GridGuide() -> some View {
//
//    CoreView()
//    //    } else {
//    //      if isPreview {
//    //        ProgressView("Loading Unit Size")
//    //          .foregroundStyle(.tertiary)
//    //          .font(.caption)
//    //      }
//    //    }  // END size check
//  }
//
//  @ViewBuilder
//  private func CoreView() -> some View {
//    Canvas {
//      context,
//      size in
//
//      context.drawGrid(
//        domain: .automatic,
//        in: size,
//        sizeMode: .fillContainer,
//        pinMode: .viewport,
//        //        lineColour: .cyan.opacity(opacity),
//        //        lineWidth: 1,
//        //        annotations: .half
//      )
//
//      //      context.drawGrid(
//      //        config: .init(
//      //          fillStyle: .fill(size: size),
//      //          colour: .cyan.opacity(opacity),
//      //          lineWidth: 1,
//      //          density: .half
//      //        ),
//      //        containerSize: size,
//      //        isInfinite: true
//      //      )
//      //      context.drawGridLines(
//      //        config: GridConfiguration(
//      //          fillStyle: .fill(size: size),
//      //          cellSize: unitSize,
//      //          colour: .cyan.opacity(opacity),
//      //          lineWidth: 1.0,
//      //          //          pan: .zero,
//      //          density: .half
//      //        ),
//      //        containerSize: size,
//      //        //        canvasZoom: 1.0
//      //      )
//
//      //      if isDrawingDebugText {
//      //        context.drawDebugText(<#T##text: String##String#>, at: <#T##CGPoint#>, pointDisplay: <#T##DebugPoint#>)
//      //        debugText(
//      //          domain: .automatic,
//      //          size: size,
//      //          //          unitSize: unitSize,
//      //          context: context
//      //        )
//      //      }
//    }
//    .frameFromGridDimensions(
//      gridDimensions: FrameGridDimensions(from: gridDimensions, alignment: layoutAlignment ?? .center)
//    )
//    //    .frame(
//    //      width: screenSize.width,
//    //      height: screenSize.height,
//    //      alignment: layoutAlignment ?? .center
//    //    )
//  }
//
//  /// Possibly refer to `VectorKit`'s `drawDebugText(_:at:positioned:colour:fontSize:pointDisplay:)`
//  //  private func debugText(
//  //    domain: UnitSizeDomain = .automatic,
//  //    size: CGSize,
//  //    //    unitSize: CGSize,
//  //    context: GraphicsContext
//  //  ) {
//  //    guard let unitSize = context.unitSize(from: domain) else { return }
//  //    let gridWidth: Int = size.width.toGridCount(using: unitSize.width, rounding: .up) ?? 0
//  //    for i in 0..<gridWidth {
//  //      context.drawDebugText(
//  //        "\(i)",
//  //        at: CGPoint(x: CGFloat(i) * unitSize.width, y: 0),
//  //        positioned: .aboveOrigin,
//  //        fontSize: 20,
//  //        pointDisplay: .none,
//  //      )
//  //    }
//  //  }
//}
//
//extension View {
//
//  public func gridGuide(
//    opacity: CGFloat = 0.1,
//    isEnabled: Bool = true
//  ) -> some View {
//    self.modifier(
//      GridGuideOverlayModifier(
//        opacity: opacity,
//        isEnabled: isEnabled
//      )
//    )
//  }
//}
