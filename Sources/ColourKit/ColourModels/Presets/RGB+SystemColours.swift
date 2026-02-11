//
//  RGB+SystemColours.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

// swift-format-ignore-file

import SwiftUI

/// Note: These aren't dynamic system colours like SwiftUI's
/// These come from standard CSS named colours
extension RGBColour {

  public static let black: RGBColour = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let white: RGBColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let gray: RGBColour = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
  public static let silver: RGBColour = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1.0)

  public static let red: RGBColour = #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let green: RGBColour = #colorLiteral(red: 0.0, green: 0.5019607843, blue: 0.0, alpha: 1.0)

  public static let blue: RGBColour = #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)

  public static let lime: RGBColour = #colorLiteral(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
  public static let navy: RGBColour = #colorLiteral(red: 0.0, green: 0.0, blue: 0.5019607843, alpha: 1.0)
  public static let teal: RGBColour = #colorLiteral(red: 0.0, green: 0.5019607843, blue: 0.5019607843, alpha: 1.0)
  public static let olive: RGBColour = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.0, alpha: 1.0)
  public static let purple: RGBColour = #colorLiteral(red: 0.5019607843, green: 0.0, blue: 0.5019607843, alpha: 1.0)
  public static let maroon: RGBColour = #colorLiteral(red: 0.5019607843, green: 0.0, blue: 0.0, alpha: 1.0)

  public static let cyan: RGBColour = #colorLiteral(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let magenta: RGBColour = #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
  public static let yellow: RGBColour = #colorLiteral(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)

  public static let orange: RGBColour = #colorLiteral(red: 1.0, green: 0.6470588235, blue: 0.0, alpha: 1.0)
  public static let brown: RGBColour = #colorLiteral(red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1.0)
  public static let pink: RGBColour = #colorLiteral(red: 1.0, green: 0.7529411765, blue: 0.7960784314, alpha: 1.0)
  public static let gold: RGBColour = #colorLiteral(red: 1.0, green: 0.8431372549, blue: 0.0, alpha: 1.0)

  public static let dodgerblue: RGBColour = #colorLiteral(red: 0.1176470588, green: 0.5647058824, blue: 1.0, alpha: 1.0)
  public static let deepskyblue: RGBColour = #colorLiteral(red: 0.0, green: 0.7490196078, blue: 1.0, alpha: 1.0)
  public static let royalblue: RGBColour = #colorLiteral(red: 0.2549019608, green: 0.4117647059, blue: 0.8823529412, alpha: 1.0)
  public static let cornflowerblue: RGBColour = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1.0)
  public static let steelblue: RGBColour = #colorLiteral(red: 0.2745098039, green: 0.5098039216, blue: 0.7058823529, alpha: 1.0)

  public static let skyblue: RGBColour = #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9215686275, alpha: 1.0)
  public static let lightblue: RGBColour = #colorLiteral(red: 0.6784313725, green: 0.8470588235, blue: 0.9019607843, alpha: 1.0)
  public static let lightskyblue: RGBColour = #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9803921569, alpha: 1.0)

  public static let seagreen: RGBColour = #colorLiteral(red: 0.1803921569, green: 0.5450980392, blue: 0.3411764706, alpha: 1.0)
  public static let mediumseagreen: RGBColour = #colorLiteral(red: 0.2352941176, green: 0.7019607843, blue: 0.4431372549, alpha: 1.0)
  public static let forestgreen: RGBColour = #colorLiteral(red: 0.1333333333, green: 0.5450980392, blue: 0.1333333333, alpha: 1.0)
  public static let darkgreen: RGBColour = #colorLiteral(red: 0.0, green: 0.3921568627, blue: 0.0, alpha: 1.0)

  public static let indigo: RGBColour = #colorLiteral(red: 0.2941176471, green: 0.0, blue: 0.5098039216, alpha: 1.0)
  public static let violet: RGBColour = #colorLiteral(red: 0.9333333333, green: 0.5098039216, blue: 0.9333333333, alpha: 1.0)
  public static let orchid: RGBColour = #colorLiteral(red: 0.8549019608, green: 0.4392156863, blue: 0.8392156863, alpha: 1.0)
  public static let rebeccapurple: RGBColour = #colorLiteral(red: 0.4, green: 0.2, blue: 0.6, alpha: 1.0)

  public static let tomato: RGBColour = #colorLiteral(red: 1.0, green: 0.3882352941, blue: 0.2784313725, alpha: 1.0)
  public static let coral: RGBColour = #colorLiteral(red: 1.0, green: 0.4980392157, blue: 0.3137254902, alpha: 1.0)
  public static let salmon: RGBColour = #colorLiteral(red: 0.9803921569, green: 0.5019607843, blue: 0.4470588235, alpha: 1.0)
  public static let darksalmon: RGBColour = #colorLiteral(red: 0.9137254902, green: 0.5882352941, blue: 0.4784313725, alpha: 1.0)

  public static let chocolate: RGBColour = #colorLiteral(red: 0.8235294118, green: 0.4117647059, blue: 0.1176470588, alpha: 1.0)
  public static let peru: RGBColour = #colorLiteral(red: 0.8039215686, green: 0.5215686275, blue: 0.2470588235, alpha: 1.0)
  public static let tan: RGBColour = #colorLiteral(red: 0.8235294118, green: 0.7058823529, blue: 0.5490196078, alpha: 1.0)
  public static let wheat: RGBColour = #colorLiteral(red: 0.9607843137, green: 0.8705882353, blue: 0.7019607843, alpha: 1.0)

  public static let aliceblue: RGBColour = #colorLiteral(red: 0.9411764706, green: 0.9725490196, blue: 1.0, alpha: 1.0)
  public static let antiquewhite: RGBColour = #colorLiteral(red: 0.9803921569, green: 0.9215686275, blue: 0.8431372549, alpha: 1.0)
  public static let ivory: RGBColour = #colorLiteral(red: 1.0, green: 1.0, blue: 0.9411764706, alpha: 1.0)
  public static let beige: RGBColour = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1.0)
  public static let whitesmoke: RGBColour = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1.0)
}
