////
////  SHapeExport.swift
////  Components
////
////  Created by Dave Coleman on 24/11/2024.
////
//
//import SwiftUI
//
//// SwiftUI Shape implementation
//struct ActionLinesShape: Shape {
//  let handler: ActionLineHandler
//  let size: CGSize
//  
//  func path(in rect: CGRect) -> Path {
//    var path = Path()
//    
//    let angles = handler.randomiser.generateRandomAngles(
//      count: Int(handler.lines.density),
//      coverage: handler.lines.radialCoverage,
//      rotation: handler.lines.rotation
//    )
//    
//    let (innerVariations, outerVariations) = handler.randomiser.generateBoundaryVariations(
//      count: Int(handler.lines.density)
//    )
//    
//    let center = CGPoint(
//      x: size.width * handler.lines.focusPoint.x,
//      y: size.height * handler.lines.focusPoint.y
//    )
//    
//    for (index, angle) in angles.enumerated() {
//      let distanceToBoundary = handler.distanceToEdge(from: center, angle: angle, in: size)
//      let lineLength = handler.calculateLineLength(for: distanceToBoundary)
//      
//      let baseInnerRadius = lineLength * handler.lines.effectiveInnerRadius
//      let innerRadiusVariation = baseInnerRadius * handler.lines.innerRandomness
//      let actualInnerRadius = baseInnerRadius +
//      (innerVariations[index] * innerRadiusVariation)
//      
//      let baseFinalLength = lineLength - actualInnerRadius
//      let lengthVariation = baseFinalLength * handler.lines.boundaryRandomness
//      let finalLength = baseFinalLength +
//      (outerVariations[index] * lengthVariation)
//      
//      let startPoint = CGPoint(
//        x: center.x + cos(angle) * actualInnerRadius,
//        y: center.y + sin(angle) * actualInnerRadius
//      )
//      
//      let endPoint = CGPoint(
//        x: startPoint.x + cos(angle) * finalLength,
//        y: startPoint.y + sin(angle) * finalLength
//      )
//      
//      // Create triangle path
//      let perpAngle = angle + .pi / 2
//      let halfWidth = handler.lines.lineStyle.width / 2
//      
//      let x1 = endPoint.x + cos(perpAngle) * halfWidth
//      let y1 = endPoint.y + sin(perpAngle) * halfWidth
//      let x2 = endPoint.x - cos(perpAngle) * halfWidth
//      let y2 = endPoint.y - sin(perpAngle) * halfWidth
//      
//      path.move(to: startPoint)
//      path.addLine(to: CGPoint(x: x1, y: y1))
//      path.addLine(to: CGPoint(x: x2, y: y2))
//      path.closeSubpath()
//    }
//    
//    return path
//  }
//}
//
////// Example usage:
////struct ContentView: View {
////  @State private var handler = ActionLineHandler()
////
////  var body: some View {
////    VStack {
////      // Original Canvas version
////      Canvas { ... }
////
////      // Shape version
////      handler.asShape(in: CGSize(width: 300, height: 300))
////        .fill(handler.lines.lineStyle.color)
////
////      Button("Export SVG") {
////        let svg = handler.exportSVG(size: CGSize(width: 300, height: 300))
////        // Handle saving the SVG
////      }
////    }
////  }
////}
