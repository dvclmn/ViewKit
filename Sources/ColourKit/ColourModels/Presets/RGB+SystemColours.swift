//
//  RGB+SystemColours.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

/// Note: These aren't dynamic system colours like SwiftUI's
/// These comes from standard CSS named colours
extension RGBColour {

  public static let black: RGBColour = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let white: RGBColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let gray: RGBColour = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
  public static let silver: RGBColour = #colorLiteral(
    red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1.0)

  public static let red: RGBColour = #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let green: RGBColour = #colorLiteral(red: 0.0, green: 0.5019607843, blue: 0.0, alpha: 1.0)

  public static let blue: RGBColour = #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)

  public static let lime: RGBColour = #colorLiteral(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
  public static let navy: RGBColour = #colorLiteral(red: 0.0, green: 0.0, blue: 0.5019607843, alpha: 1.0)
  public static let teal: RGBColour = #colorLiteral(
    red: 0.0, green: 0.5019607843, blue: 0.5019607843, alpha: 1.0)
  public static let olive: RGBColour = #colorLiteral(
    red: 0.5019607843, green: 0.5019607843, blue: 0.0, alpha: 1.0)
  public static let purple: RGBColour = #colorLiteral(
    red: 0.5019607843, green: 0.0, blue: 0.5019607843, alpha: 1.0)
  public static let maroon: RGBColour = #colorLiteral(red: 0.5019607843, green: 0.0, blue: 0.0, alpha: 1.0)

  public static let cyan: RGBColour = #colorLiteral(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let magenta: RGBColour = #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
  public static let yellow: RGBColour = #colorLiteral(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)

  public static let orange: RGBColour = #colorLiteral(red: 1.0, green: 0.6470588235, blue: 0.0, alpha: 1.0)
  public static let brown: RGBColour = #colorLiteral(
    red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1.0)
  public static let pink: RGBColour = #colorLiteral(
    red: 1.0, green: 0.7529411765, blue: 0.7960784314, alpha: 1.0)
  public static let gold: RGBColour = #colorLiteral(red: 1.0, green: 0.8431372549, blue: 0.0, alpha: 1.0)

  public static let dodgerblue: RGBColour = #colorLiteral(
    red: 0.1176470588, green: 0.5647058824, blue: 1.0, alpha: 1.0)
  public static let deepskyblue: RGBColour = #colorLiteral(
    red: 0.0, green: 0.7490196078, blue: 1.0, alpha: 1.0)
  public static let royalblue: RGBColour = #colorLiteral(
    red: 0.2549019608, green: 0.4117647059, blue: 0.8823529412, alpha: 1.0)
  public static let cornflowerblue: RGBColour = #colorLiteral(
    red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1.0)
  public static let steelblue: RGBColour = #colorLiteral(
    red: 0.2745098039, green: 0.5098039216, blue: 0.7058823529, alpha: 1.0)

  public static let skyblue: RGBColour = #colorLiteral(
    red: 0.5294117647, green: 0.8078431373, blue: 0.9215686275, alpha: 1.0)
  public static let lightblue: RGBColour = #colorLiteral(
    red: 0.6784313725, green: 0.8470588235, blue: 0.9019607843, alpha: 1.0)
  public static let lightskyblue: RGBColour = #colorLiteral(
    red: 0.5294117647, green: 0.8078431373, blue: 0.9803921569, alpha: 1.0)

  public static let seagreen: RGBColour = #colorLiteral(
    red: 0.1803921569, green: 0.5450980392, blue: 0.3411764706, alpha: 1.0)
  public static let mediumseagreen: RGBColour = #colorLiteral(
    red: 0.2352941176, green: 0.7019607843, blue: 0.4431372549, alpha: 1.0)
  public static let forestgreen: RGBColour = #colorLiteral(
    red: 0.1333333333, green: 0.5450980392, blue: 0.1333333333, alpha: 1.0)
  public static let darkgreen: RGBColour = #colorLiteral(red: 0.0, green: 0.3921568627, blue: 0.0, alpha: 1.0)

  public static let indigo: RGBColour = #colorLiteral(
    red: 0.2941176471, green: 0.0, blue: 0.5098039216, alpha: 1.0)
  public static let violet: RGBColour = #colorLiteral(
    red: 0.9333333333, green: 0.5098039216, blue: 0.9333333333, alpha: 1.0)
  public static let orchid: RGBColour = #colorLiteral(
    red: 0.8549019608, green: 0.4392156863, blue: 0.8392156863, alpha: 1.0)
  public static let rebeccapurple: RGBColour = #colorLiteral(red: 0.4, green: 0.2, blue: 0.6, alpha: 1.0)

  public static let tomato: RGBColour = #colorLiteral(
    red: 1.0, green: 0.3882352941, blue: 0.2784313725, alpha: 1.0)
  public static let coral: RGBColour = #colorLiteral(
    red: 1.0, green: 0.4980392157, blue: 0.3137254902, alpha: 1.0)
  public static let salmon: RGBColour = #colorLiteral(
    red: 0.9803921569, green: 0.5019607843, blue: 0.4470588235, alpha: 1.0)
  public static let darksalmon: RGBColour = #colorLiteral(
    red: 0.9137254902, green: 0.5882352941, blue: 0.4784313725, alpha: 1.0)

  public static let chocolate: RGBColour = #colorLiteral(
    red: 0.8235294118, green: 0.4117647059, blue: 0.1176470588, alpha: 1.0)
  public static let peru: RGBColour = #colorLiteral(
    red: 0.8039215686, green: 0.5215686275, blue: 0.2470588235, alpha: 1.0)
  public static let tan: RGBColour = #colorLiteral(
    red: 0.8235294118, green: 0.7058823529, blue: 0.5490196078, alpha: 1.0)
  public static let wheat: RGBColour = #colorLiteral(
    red: 0.9607843137, green: 0.8705882353, blue: 0.7019607843, alpha: 1.0)

  public static let aliceblue: RGBColour = #colorLiteral(
    red: 0.9411764706, green: 0.9725490196, blue: 1.0, alpha: 1.0)
  public static let antiquewhite: RGBColour = #colorLiteral(
    red: 0.9803921569, green: 0.9215686275, blue: 0.8431372549, alpha: 1.0)
  public static let ivory: RGBColour = #colorLiteral(red: 1.0, green: 1.0, blue: 0.9411764706, alpha: 1.0)
  public static let beige: RGBColour = #colorLiteral(
    red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1.0)
  public static let whitesmoke: RGBColour = #colorLiteral(
    red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1.0)
}
//  #if DEBUG
//  public enum VisualSwatches {
//    // Core
//    public static let black: RGBColour = RGBColour(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
//    public static let white: Color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//    public static let gray: Color = Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))
//    public static let silver: Color = Color(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1))
//
//    // Primaries/secondaries
//    public static let red = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//    public static let green = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
//    public static let blue = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
//    public static let cyan = #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1)
//    public static let magenta = #colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)
//    public static let yellow = #colorLiteral(red: 1, green: 1, blue: 0, alpha: 1)
//
//    // Extras
//    public static let orange = #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1)
//    public static let brown = #colorLiteral(red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1)
//    public static let pink = #colorLiteral(red: 1, green: 0.7529411765, blue: 0.7960784314, alpha: 1)
//    public static let gold = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
//
//    // Blues
//    public static let dodgerblue = #colorLiteral(red: 0.1176470588, green: 0.5647058824, blue: 1, alpha: 1)
//    public static let deepskyblue = #colorLiteral(red: 0, green: 0.7490196078, blue: 1, alpha: 1)
//    public static let royalblue = #colorLiteral(red: 0.2549019608, green: 0.4117647059, blue: 0.8823529412, alpha: 1)
//    public static let cornflowerblue = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
//    public static let steelblue = #colorLiteral(red: 0.2745098039, green: 0.5098039216, blue: 0.7058823529, alpha: 1)
//
//    // Greens
//    public static let seagreen = #colorLiteral(red: 0.1803921569, green: 0.5450980392, blue: 0.3411764706, alpha: 1)
//    public static let mediumseagreen = #colorLiteral(red: 0.2352941176, green: 0.7019607843, blue: 0.4431372549, alpha: 1)
//    public static let forestgreen = #colorLiteral(red: 0.1333333333, green: 0.5450980392, blue: 0.1333333333, alpha: 1)
//    public static let darkgreen = #colorLiteral(red: 0, green: 0.3921568627, blue: 0, alpha: 1)
//
//    // Purples
//    public static let indigo = #colorLiteral(red: 0.2941176471, green: 0, blue: 0.5098039216, alpha: 1)
//    public static let violet = #colorLiteral(red: 0.9333333333, green: 0.5098039216, blue: 0.9333333333, alpha: 1)
//    public static let orchid = #colorLiteral(red: 0.8549019608, green: 0.4392156863, blue: 0.8392156863, alpha: 1)
//    public static let rebeccapurple = #colorLiteral(red: 0.4, green: 0.2, blue: 0.6, alpha: 1)
//
//    // Neutrals
//    public static let aliceblue = #colorLiteral(red: 0.9411764706, green: 0.9725490196, blue: 1, alpha: 1)
//    public static let antiquewhite = #colorLiteral(red: 0.9803921569, green: 0.9215686275, blue: 0.8431372549, alpha: 1)
//    public static let ivory = #colorLiteral(red: 1, green: 1, blue: 0.9411764706, alpha: 1)
//    public static let beige = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1)
//    public static let whitesmoke = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
//  }
//}
//  public static let black: RGBColour = .from255(0, 0, 0, name: "black")
//  public static let silver: RGBColour = .from255(192, 192, 192, name: "silver")
//  public static let gray: RGBColour = .from255(128, 128, 128, name: "gray")
//  public static let white: RGBColour = .from255(255, 255, 255, name: "white")
//  public static let maroon: RGBColour = .from255(128, 0, 0, name: "maroon")
//  public static let red: RGBColour = .from255(255, 0, 0, name: "red")
//  public static let purple: RGBColour = .from255(128, 0, 128, name: "purple")
//  public static let magenta: RGBColour = .from255(255, 0, 255, name: "magenta")
//  public static let green: RGBColour = .from255(0, 128, 0, name: "green")
//  public static let lime: RGBColour = .from255(0, 255, 0, name: "lime")
//  public static let olive: RGBColour = .from255(128, 128, 0, name: "olive")
//  public static let yellow: RGBColour = .from255(255, 255, 0, name: "yellow")
//  public static let navy: RGBColour = .from255(0, 0, 128, name: "navy")
//  public static let blue: RGBColour = .from255(0, 0, 255, name: "blue")
//  public static let teal: RGBColour = .from255(0, 128, 128, name: "teal")
//  public static let cyan: RGBColour = .from255(0, 255, 255, name: "cyan")
//  public static let aqua: RGBColour = .from255(0, 255, 255, name: "aqua")
//  public static let orange: RGBColour = .from255(255, 165, 0, name: "orange")
//  public static let aliceblue: RGBColour = .from255(240, 248, 255, name: "aliceblue")
//  public static let antiquewhite: RGBColour = .from255(250, 235, 215, name: "antiquewhite")
//  public static let aquamarine: RGBColour = .from255(127, 255, 212, name: "aquamarine")
//  public static let azure: RGBColour = .from255(240, 255, 255, name: "azure")
//  public static let beige: RGBColour = .from255(245, 245, 220, name: "beige")
//  public static let bisque: RGBColour = .from255(255, 228, 196, name: "bisque")
//  public static let blanchedalmond: RGBColour = .from255(255, 235, 205, name: "blanchedalmond")
//  public static let blueviolet: RGBColour = .from255(138, 43, 226, name: "blueviolet")
//  public static let brown: RGBColour = .from255(165, 42, 42, name: "brown")
//  public static let burlywood: RGBColour = .from255(222, 184, 135, name: "burlywood")
//  public static let cadetblue: RGBColour = .from255(95, 158, 160, name: "cadetblue")
//  public static let chartreuse: RGBColour = .from255(127, 255, 0, name: "chartreuse")
//  public static let chocolate: RGBColour = .from255(210, 105, 30, name: "chocolate")
//  public static let coral: RGBColour = .from255(255, 127, 80, name: "coral")
//  public static let cornflowerblue: RGBColour = .from255(100, 149, 237, name: "cornflowerblue")
//  public static let cornsilk: RGBColour = .from255(255, 248, 220, name: "cornsilk")
//  public static let crimson: RGBColour = .from255(220, 20, 60, name: "crimson")
//  public static let darkblue: RGBColour = .from255(0, 0, 139, name: "darkblue")
//  public static let darkcyan: RGBColour = .from255(0, 139, 139, name: "darkcyan")
//  public static let darkgoldenrod: RGBColour = .from255(184, 134, 11, name: "darkgoldenrod")
//  public static let darkgray: RGBColour = .from255(169, 169, 169, name: "darkgray")
//  public static let darkgreen: RGBColour = .from255(0, 100, 0, name: "darkgreen")
//  public static let darkkhaki: RGBColour = .from255(189, 183, 107, name: "darkkhaki")
//  public static let darkmagenta: RGBColour = .from255(139, 0, 139, name: "darkmagenta")
//  public static let darkolivegreen: RGBColour = .from255(85, 107, 47, name: "darkolivegreen")
//  public static let darkorange: RGBColour = .from255(255, 140, 0, name: "darkorange")
//  public static let darkorchid: RGBColour = .from255(153, 50, 204, name: "darkorchid")
//  public static let darkred: RGBColour = .from255(139, 0, 0, name: "darkred")
//  public static let darksalmon: RGBColour = .from255(233, 150, 122, name: "darksalmon")
//  public static let darkseagreen: RGBColour = .from255(143, 188, 143, name: "darkseagreen")
//  public static let darkslateblue: RGBColour = .from255(72, 61, 139, name: "darkslateblue")
//  public static let darkslategray: RGBColour = .from255(47, 79, 79, name: "darkslategray")
//  public static let darkturquoise: RGBColour = .from255(0, 206, 209, name: "darkturquoise")
//  public static let darkviolet: RGBColour = .from255(148, 0, 211, name: "darkviolet")
//  public static let deeppink: RGBColour = .from255(255, 20, 147, name: "deeppink")
//  public static let deepskyblue: RGBColour = .from255(0, 191, 255, name: "deepskyblue")
//  public static let dimgray: RGBColour = .from255(105, 105, 105, name: "dimgray")
//  public static let dodgerblue: RGBColour = .from255(30, 144, 255, name: "dodgerblue")
//  public static let firebrick: RGBColour = .from255(178, 34, 34, name: "firebrick")
//  public static let floralwhite: RGBColour = .from255(255, 250, 240, name: "floralwhite")
//  public static let forestgreen: RGBColour = .from255(34, 139, 34, name: "forestgreen")
//  public static let gainsboro: RGBColour = .from255(220, 220, 220, name: "gainsboro")
//  public static let ghostwhite: RGBColour = .from255(248, 248, 255, name: "ghostwhite")
//  public static let gold: RGBColour = .from255(255, 215, 0, name: "gold")
//  public static let goldenrod: RGBColour = .from255(218, 165, 32, name: "goldenrod")
//  public static let greenyellow: RGBColour = .from255(173, 255, 47, name: "greenyellow")
//  public static let honeydew: RGBColour = .from255(240, 255, 240, name: "honeydew")
//  public static let hotpink: RGBColour = .from255(255, 105, 180, name: "hotpink")
//  public static let indianred: RGBColour = .from255(205, 92, 92, name: "indianred")
//  public static let indigo: RGBColour = .from255(75, 0, 130, name: "indigo")
//  public static let ivory: RGBColour = .from255(255, 255, 240, name: "ivory")
//  public static let khaki: RGBColour = .from255(240, 230, 140, name: "khaki")
//  public static let lavender: RGBColour = .from255(230, 230, 250, name: "lavender")
//  public static let lavenderblush: RGBColour = .from255(255, 240, 245, name: "lavenderblush")
//  public static let lawngreen: RGBColour = .from255(124, 252, 0, name: "lawngreen")
//  public static let lemonchiffon: RGBColour = .from255(255, 250, 205, name: "lemonchiffon")
//  public static let lightblue: RGBColour = .from255(173, 216, 230, name: "lightblue")
//  public static let lightcoral: RGBColour = .from255(240, 128, 128, name: "lightcoral")
//  public static let lightcyan: RGBColour = .from255(224, 255, 255, name: "lightcyan")
//  public static let lightgoldenrodyellow: RGBColour = .from255(250, 250, 210, name: "lightgoldenrodyellow")
//  public static let lightgray: RGBColour = .from255(211, 211, 211, name: "lightgray")
//  public static let lightgreen: RGBColour = .from255(144, 238, 144, name: "lightgreen")
//  public static let lightpink: RGBColour = .from255(255, 182, 193, name: "lightpink")
//  public static let lightsalmon: RGBColour = .from255(255, 160, 122, name: "lightsalmon")
//  public static let lightseagreen: RGBColour = .from255(32, 178, 170, name: "lightseagreen")
//  public static let lightskyblue: RGBColour = .from255(135, 206, 250, name: "lightskyblue")
//  public static let lightslategray: RGBColour = .from255(119, 136, 153, name: "lightslategray")
//  public static let lightsteelblue: RGBColour = .from255(176, 196, 222, name: "lightsteelblue")
//  public static let lightyellow: RGBColour = .from255(255, 255, 224, name: "lightyellow")
//  public static let limegreen: RGBColour = .from255(50, 205, 50, name: "limegreen")
//  public static let linen: RGBColour = .from255(250, 240, 230, name: "linen")
//  public static let mediumaquamarine: RGBColour = .from255(102, 205, 170, name: "mediumaquamarine")
//  public static let mediumblue: RGBColour = .from255(0, 0, 205, name: "mediumblue")
//  public static let mediumorchid: RGBColour = .from255(186, 85, 211, name: "mediumorchid")
//  public static let mediumpurple: RGBColour = .from255(147, 112, 219, name: "mediumpurple")
//  public static let mediumseagreen: RGBColour = .from255(60, 179, 113, name: "mediumseagreen")
//  public static let mediumslateblue: RGBColour = .from255(123, 104, 238, name: "mediumslateblue")
//  public static let mediumspringgreen: RGBColour = .from255(0, 250, 154, name: "mediumspringgreen")
//  public static let mediumturquoise: RGBColour = .from255(72, 209, 204, name: "mediumturquoise")
//  public static let mediumvioletred: RGBColour = .from255(199, 21, 133, name: "mediumvioletred")
//  public static let midnightblue: RGBColour = .from255(25, 25, 112, name: "midnightblue")
//  public static let mintcream: RGBColour = .from255(245, 255, 250, name: "mintcream")
//  public static let mistyrose: RGBColour = .from255(255, 228, 225, name: "mistyrose")
//  public static let moccasin: RGBColour = .from255(255, 228, 181, name: "moccasin")
//  public static let navajowhite: RGBColour = .from255(255, 222, 173, name: "navajowhite")
//  public static let oldlace: RGBColour = .from255(253, 245, 230, name: "oldlace")
//  public static let olivedrab: RGBColour = .from255(107, 142, 35, name: "olivedrab")
//  public static let orangered: RGBColour = .from255(255, 69, 0, name: "orangered")
//  public static let orchid: RGBColour = .from255(218, 112, 214, name: "orchid")
//  public static let palegoldenrod: RGBColour = .from255(238, 232, 170, name: "palegoldenrod")
//  public static let palegreen: RGBColour = .from255(152, 251, 152, name: "palegreen")
//  public static let paleturquoise: RGBColour = .from255(175, 238, 238, name: "paleturquoise")
//  public static let palevioletred: RGBColour = .from255(219, 112, 147, name: "palevioletred")
//  public static let papayawhip: RGBColour = .from255(255, 239, 213, name: "papayawhip")
//  public static let peachpuff: RGBColour = .from255(255, 218, 185, name: "peachpuff")
//  public static let peru: RGBColour = .from255(205, 133, 63, name: "peru")
//  public static let pink: RGBColour = .from255(255, 192, 203, name: "pink")
//  public static let plum: RGBColour = .from255(221, 160, 221, name: "plum")
//  public static let powderblue: RGBColour = .from255(176, 224, 230, name: "powderblue")
//  public static let rosybrown: RGBColour = .from255(188, 143, 143, name: "rosybrown")
//  public static let royalblue: RGBColour = .from255(65, 105, 225, name: "royalblue")
//  public static let saddlebrown: RGBColour = .from255(139, 69, 19, name: "saddlebrown")
//  public static let salmon: RGBColour = .from255(250, 128, 114, name: "salmon")
//  public static let sandybrown: RGBColour = .from255(244, 164, 96, name: "sandybrown")
//  public static let seagreen: RGBColour = .from255(46, 139, 87, name: "seagreen")
//  public static let seashell: RGBColour = .from255(255, 245, 238, name: "seashell")
//  public static let sienna: RGBColour = .from255(160, 82, 45, name: "sienna")
//  public static let skyblue: RGBColour = .from255(135, 206, 235, name: "skyblue")
//  public static let slateblue: RGBColour = .from255(106, 90, 205, name: "slateblue")
//  public static let slategray: RGBColour = .from255(112, 128, 144, name: "slategray")
//  public static let snow: RGBColour = .from255(255, 250, 250, name: "snow")
//  public static let springgreen: RGBColour = .from255(0, 255, 127, name: "springgreen")
//  public static let steelblue: RGBColour = .from255(70, 130, 180, name: "steelblue")
//  public static let tan: RGBColour = .from255(210, 180, 140, name: "tan")
//  public static let thistle: RGBColour = .from255(216, 191, 216, name: "thistle")
//  public static let tomato: RGBColour = .from255(255, 99, 71, name: "tomato")
//  public static let turquoise: RGBColour = .from255(64, 224, 208, name: "turquoise")
//  public static let violet: RGBColour = .from255(238, 130, 238, name: "violet")
//  public static let wheat: RGBColour = .from255(245, 222, 179, name: "wheat")
//  public static let whitesmoke: RGBColour = .from255(245, 245, 245, name: "whitesmoke")
//  public static let yellowgreen: RGBColour = .from255(154, 205, 50, name: "yellowgreen")
//  public static let rebeccapurple: RGBColour = .from255(102, 51, 153, name: "rebeccapurple")
//}
