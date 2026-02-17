//
//  Luma+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI

public protocol LuminanceReadable {
  func luminance(using method: LuminanceMethod) -> Double
  func luminanceThreshold(using method: LuminanceMethod) -> LuminanceThreshold
}

public enum LuminanceMethod: Sendable, Codable {
  case wcag  // Rec.709 coefficients, linearised sRGB
  case rec601  // Video standard
  case hsp  // Perceived brightness
  case cielab  // CIE L* lightness
}

//
//extension LuminanceReadable {

//extension Color: LuminanceReadable {
//  public func luminance(using method: LuminanceMethod = .wcag) -> Double {
//    fatalError("Not yet implemented")
////    RGBColour(colour: <#T##Color#>, environment: <#T##EnvironmentValues#>, name: <#T##String?#>)
////    RGBColour(fromHSV: self).luminance(using: method)
//  }
//
//  public func luminanceThreshold(using method: LuminanceMethod) -> LuminanceThreshold {
//    fatalError("Not yet implemented")
////    RGBColour(fromHSV: self).luminanceThreshold(using: method)
//  }
//
//}
//
//extension CodableColour: LuminanceReadable {
//  public func luminance(using method: LuminanceMethod = .wcag) -> Double {
//    fatalError("Not yet implemented")
//  }
//
//  public func luminanceThreshold(using method: LuminanceMethod) -> LuminanceThreshold {
//    fatalError("Not yet implemented")
//  }
//}
