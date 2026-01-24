//
//  SVGExport.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import SwiftUI
//
//struct ActionLinesSVG: Transferable {
//  
//  static var transferRepresentation: some TransferRepresentation {
//    DataRepresentation(exportedContentType: .svg) { file in
//      Data(file.csvData().utf8)
//    }
//  }
//  
//  var content: String
//}
//
//extension ActionLineHandler {
//  // MARK: - SVG Export
//  func exportSVG(
//    size: CGSize,
//    angles: [Double],
//    variations: BoundaryVariations,
//    center: CGPoint
//  ) -> String {
////    let angles = randomiser.generateRandomAngles(
////      count: Int(lines.density),
////      coverage: lines.radialCoverage,
////      rotation: lines.rotation
////    )
//    
////    let (innerVariations, outerVariations) = randomiser.generateBoundaryVariations(
////      count: Int(lines.density)
////    )
//    
////    let center = CGPoint(
////      x: size.width * lines.focusPoint.x,
////      y: size.height * lines.focusPoint.y
////    )
//    
//    // Generate path data for each line
//    let pathElements = angles.enumerated().map { index, angle in
//      let distanceToBoundary = distanceToEdge(from: center, angle: angle, in: size)
//      let lineLength = calculateLineLength(for: distanceToBoundary)
//      
//      let baseInnerRadius = lineLength * lines.effectiveInnerRadius
//      let innerRadiusVariation = baseInnerRadius * lines.innerRandomness
//      let actualInnerRadius = baseInnerRadius +
//      (variations.inner[index] * innerRadiusVariation)
//      
//      let baseFinalLength = lineLength - actualInnerRadius
//      let lengthVariation = baseFinalLength * lines.boundaryRandomness
//      let finalLength = baseFinalLength +
//      (variations.inner[index] * lengthVariation)
//      
//      // Calculate triangle points
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
//      // Calculate triangle points for width
//      let perpAngle = angle + .pi / 2
//      let halfWidth = lines.lineStyle.width / 2
//      
//      let x1 = endPoint.x + cos(perpAngle) * halfWidth
//      let y1 = endPoint.y + sin(perpAngle) * halfWidth
//      let x2 = endPoint.x - cos(perpAngle) * halfWidth
//      let y2 = endPoint.y - sin(perpAngle) * halfWidth
//      
//      // Create SVG path for triangle
//      return """
//                <path d="M \(startPoint.x),\(startPoint.y) 
//                         L \(x1),\(y1) 
//                         L \(x2),\(y2) Z"
//                      fill="\(lines.lineStyle.color.svgString)"
//                      stroke="none"/>
//            """
//    }
//    
//    return """
//        <?xml version="1.0" encoding="UTF-8"?>
//        <svg width="\(size.width)" height="\(size.height)" 
//             xmlns="http://www.w3.org/2000/svg">
//            \(pathElements.joined(separator: "\n    "))
//        </svg>
//        """
//  }
//  
////  // MARK: - SwiftUI Shape Export
////  func asShape(in size: CGSize) -> some Shape {
////    ActionLinesShape(
////      handler: self,
////      size: size
////    )
////  }
//}
//
//// Helper for color conversion
//extension Color {
//  var svgString: String {
//    // This is a simplified version - you might want to add more color space handling
//    "rgb(0,0,0)" // Default to black for now
//  }
//}
