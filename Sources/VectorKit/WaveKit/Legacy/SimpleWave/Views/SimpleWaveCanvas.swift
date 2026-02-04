//
//  SimpleWaveCanvas.swift
//  BaseDemos
//
//  Created by Dave Coleman on 29/1/2026.
//

import MotionKit
import SwiftUI
import ToolKit
import VectorKit

//struct SimpleWaveCanvas: View {
//  @Environment(\.animationClock) private var animationClock
//  @Environment(\.self) private var env
//  let store: SimpleWaveHandler
//
//  var body: some View {
//
//    Canvas(
//      opaque: true,
//      rendersAsynchronously: true
//    ) {
//      context,
//      size in
//
//      Task { @MainActor in
//        store.waveGenerator.resetAll()
//        }
//      let width = size.width
//      let height = size.height
//      
////      let width = Float(size.width)
////      let height = Float(size.height)
//
//      let baseX = width / 2
//      /// Vertical is the 'main wave' for some wave aspects,
//      /// such as sample count
//
//      let sampleCount = store.wave.config.sampleCount
//      //      var points: [CGPoint] = []
//
//      /// Loop over sample count
//      for i in 0..<sampleCount {
//
//        /// Distribute dots vertically.
//        /// Higher frequency = shorter total wave height.
//        let index: Double = i.normalisedIndex(for: sampleCount)
//        let baseY = index.lerp(from: height, to: 0)
//
//        let offsetX =
//          store.wave.sample(
//            state: store.waveState,
//            at: index
////            at: Float(index)
//          )
//
//        /// Add the offset to the base style radius (clamped to 0)
//        //        let radiusModulated = max(0, store.radius + offsetX)
//        //        let radiusModulated = max(0, styles.pointStyle.radius + radiusOffset)
//
//        /// 4. CONSTRUCT THE FINAL COORDINATES
//        let finalX = baseX + offsetX
//        let finalY = baseY
//
//        let dotCentre = CGPoint(
//          x: Double(finalX),
//          y: Double(finalY)
//        )
//
//        Task { @MainActor in
//          //          store.points
//          store.waveGenerator.points.append(dotCentre)
//          store.waveGenerator.updatePath(with: store.wave.configuredWave.config.interpolation)
//          //          store.path.editPath(using: store.points, interpolation: store.wave.config.interpolation)
//        }
//
//        context.withCGContext { cgContext in
//          cgContext.setShouldAntialias(false)
//          //          cgContext.addPath(store.waveGenerator.path.cgPath)
//          //          let point = cgContext.currentPointOfPath
//          let dotRect = CGRect(
//            origin: dotCentre, size: CGSize(fromLength: store.wave.style.pointStyle.radius * 2))
//          //          let path = CGPath(ellipseIn: CGRect(origin: point, size: CGSize(20,  20)), transform: nil)
//          #warning("This right here is 100%-ing the CPU, `cgContext.addPath(store.waveGenerator.path.cgPath)`")
//          cgContext.addPath(store.waveGenerator.path.cgPath)
//
//          cgContext.setStrokeColor(store.wave.style.lineStyle.colour.toColour.toCGColor(using: env))
//          //          cgContext.setStrokeColor(CGColor(red: 0.2, green: 0.4, blue: 0.1, alpha: 1.0))
//          cgContext.strokePath()
//
//          //          cgContext.fillPath()
//
//          //          cgContext.synchronizeAttributes()
//
//          cgContext.setFillColor(store.wave.style.pointStyle.colour.toColour.toCGColor(using: env))
//          //          print("Points: \(store.waveGenerator.points.count)")
//          //          cgContext.strokeLineSegments(between: store.waveGenerator.points)
//          //          cgContext.drawPath(using: .fill)
//
//          cgContext.addEllipse(in: dotRect)
//
//          cgContext.fillPath()
//        }
//      }
//    }  // END canvas
////    .task(id: store.wave.config.interpolation) {
////      store.waveGenerator.updateInterpolation(store.wave.config.interpolation)
////    }
//  }
//}
//extension SimpleWaveCanvas {
//  private var dotDiameter: CGFloat { CGFloat(store.radius * 2) }
//  //  private func waveLoop() {
//  //
//  //  }
//}
