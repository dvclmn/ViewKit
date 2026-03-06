//
//  Adjustment+Exts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

/// These may be handy, but don't seem to
//extension Color {
//  public func toHSVAdustment(using colourSpace: RGBColorSpace = .sRGB) -> HSVAdjustment? {
//    //  public func toHSVAdustment(using colourSpace: NSColorSpace = .deviceRGB) -> HSVAdjustment? {
//    let nsColour = self.toNSColor.usingColorSpace(colourSpace)
//    return nsColour?.toHSVAdustment(using: colourSpace)
//  }
//  
//  public func hsvAdjusted(by adjustment: HSVAdjustment) -> Color? {
//    guard let baseAdjustment = toHSVAdustment() else { return nil }
//    let adjusted: HSVAdjustment = baseAdjustment.interpolated(towards: adjustment)
//    return adjusted.toColour()
//  }
//}
//
//extension NSColor {
//  public func toHSVAdustment(using colourSpace: NSColorSpace = .deviceRGB) -> HSVAdjustment? {
//    //    let nsColour = self.toNSColor.usingColorSpace(colourSpace)
//    return HSVAdjustment(h: hueComponent, s: saturationComponent, v: brightnessComponent)
//  }
//}
