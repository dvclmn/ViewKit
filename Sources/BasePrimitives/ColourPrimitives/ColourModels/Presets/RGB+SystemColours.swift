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
  
  // MARK: - SwiftUI System Colours (dark-mode approximations)
  public static let red: RGBColour       = #colorLiteral(red: 1.0,   green: 0.271, blue: 0.227, alpha: 1.0)
  public static let orange: RGBColour    = #colorLiteral(red: 1.0,   green: 0.624, blue: 0.039, alpha: 1.0)
  public static let yellow: RGBColour    = #colorLiteral(red: 1.0,   green: 0.839, blue: 0.039, alpha: 1.0)
  public static let green: RGBColour     = #colorLiteral(red: 0.188, green: 0.820, blue: 0.345, alpha: 1.0)
  public static let mint: RGBColour      = #colorLiteral(red: 0.388, green: 0.902, blue: 0.886, alpha: 1.0)
  public static let teal: RGBColour      = #colorLiteral(red: 0.251, green: 0.784, blue: 0.878, alpha: 1.0)
  public static let cyan: RGBColour      = #colorLiteral(red: 0.392, green: 0.824, blue: 0.988, alpha: 1.0)
  public static let blue: RGBColour      = #colorLiteral(red: 0.039, green: 0.518, blue: 1.0, alpha: 1.0)
  public static let indigo: RGBColour    = #colorLiteral(red: 0.345, green: 0.337, blue: 0.839, alpha: 1.0)
  public static let purple: RGBColour    = #colorLiteral(red: 0.749, green: 0.353, blue: 0.949, alpha: 1.0)
  public static let pink: RGBColour      = #colorLiteral(red: 1.0,   green: 0.216, blue: 0.373, alpha: 1.0)
  public static let brown: RGBColour     = #colorLiteral(red: 0.635, green: 0.518, blue: 0.369, alpha: 1.0)

  public static func system(
    _ colour: SystemColour,
    in env: EnvironmentValues
  ) -> RGBColour {
    RGBColour(fromSystem: colour, env: env)
  }
  // MARK: - Basic 16 (CSS Level 1 & 2)
  public static let black: RGBColour =                  #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let white: RGBColour =                  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let silver: RGBColour =                 #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1.0)
  public static let gray: RGBColour =                   #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1.0)
  public static let grayAlt: RGBColour =                #colorLiteral(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
  public static let redWeb: RGBColour =                 #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let maroon: RGBColour =                 #colorLiteral(red: 0.5019607843, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let yellowWeb: RGBColour =              #colorLiteral(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
  public static let olive: RGBColour =                  #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.0, alpha: 1.0)
  public static let lime: RGBColour =                   #colorLiteral(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
  public static let greenWeb: RGBColour =               #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
  public static let aqua: RGBColour =                   #colorLiteral(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let tealWeb: RGBColour =                #colorLiteral(red: 0.0, green: 0.5019607843, blue: 0.5019607843, alpha: 1.0)
  public static let blueWeb: RGBColour =                #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
  public static let navy: RGBColour =                   #colorLiteral(red: 0.0, green: 0.0, blue: 0.5019607843, alpha: 1.0)
  public static let fuchsia: RGBColour =                #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
  public static let purpleWeb: RGBColour =              #colorLiteral(red: 0.5019607843, green: 0.0, blue: 0.5019607843, alpha: 1.0)
  
  // MARK: - Aliases for basic colours
  
  /// cyan = aqua (`#00ffff`)
  public static let cyanWeb: RGBColour =                #colorLiteral(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
  /// magenta = fuchsia (`#ff00ff`)
  public static let magenta: RGBColour =                #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
  /// grey = gray (`#808080`)
  public static let grey: RGBColour =                   #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1.0)
  
  // MARK: - Reds
  public static let tomato: RGBColour =                 #colorLiteral(red: 1.0, green: 0.3882352941, blue: 0.2784313725, alpha: 1.0)
  public static let orangered: RGBColour =              #colorLiteral(red: 1.0, green: 0.2705882353, blue: 0.0, alpha: 1.0)
  public static let coral: RGBColour =                  #colorLiteral(red: 1.0, green: 0.4980392157, blue: 0.3137254902, alpha: 1.0)
  public static let crimson: RGBColour =                #colorLiteral(red: 0.862745098, green: 0.0784313725, blue: 0.2352941176, alpha: 1.0)
  public static let firebrick: RGBColour =              #colorLiteral(red: 0.6980392157, green: 0.1333333333, blue: 0.1333333333, alpha: 1.0)
  public static let darkred: RGBColour =                #colorLiteral(red: 0.5450980392, green: 0.0, blue: 0.0, alpha: 1.0)
  public static let indianred: RGBColour =              #colorLiteral(red: 0.8039215686, green: 0.3607843137, blue: 0.3607843137, alpha: 1.0)
  public static let lightcoral: RGBColour =             #colorLiteral(red: 0.9411764706, green: 0.5019607843, blue: 0.5019607843, alpha: 1.0)
  public static let salmon: RGBColour =                 #colorLiteral(red: 0.9803921569, green: 0.5019607843, blue: 0.4470588235, alpha: 1.0)
  public static let darksalmon: RGBColour =             #colorLiteral(red: 0.9137254902, green: 0.5882352941, blue: 0.4784313725, alpha: 1.0)
  public static let lightsalmon: RGBColour =            #colorLiteral(red: 1.0, green: 0.6274509804, blue: 0.4784313725, alpha: 1.0)
  
  // MARK: - Pinks
  public static let pinkWeb: RGBColour =                #colorLiteral(red: 1.0, green: 0.7529411765, blue: 0.7960784314, alpha: 1.0)
  public static let lightpink: RGBColour =              #colorLiteral(red: 1.0, green: 0.7137254902, blue: 0.7568627451, alpha: 1.0)
  public static let hotpink: RGBColour =                #colorLiteral(red: 1.0, green: 0.4117647059, blue: 0.7058823529, alpha: 1.0)
  public static let deeppink: RGBColour =               #colorLiteral(red: 1.0, green: 0.0784313725, blue: 0.5764705882, alpha: 1.0)
  public static let palevioletred: RGBColour =          #colorLiteral(red: 0.8588235294, green: 0.4392156863, blue: 0.5764705882, alpha: 1.0)
  public static let mediumvioletred: RGBColour =        #colorLiteral(red: 0.7803921569, green: 0.0823529412, blue: 0.5215686275, alpha: 1.0)
  
  // MARK: - Oranges
  public static let orangeWeb: RGBColour =              #colorLiteral(red: 1.0, green: 0.6470588235, blue: 0.0, alpha: 1.0)
  public static let darkorange: RGBColour =             #colorLiteral(red: 1.0, green: 0.5490196078, blue: 0.0, alpha: 1.0)
  
  // MARK: - Yellows
  public static let gold: RGBColour =                   #colorLiteral(red: 1.0, green: 0.8431372549, blue: 0.0, alpha: 1.0)
  public static let goldenrod: RGBColour =              #colorLiteral(red: 0.8549019608, green: 0.6470588235, blue: 0.1254901961, alpha: 1.0)
  public static let darkgoldenrod: RGBColour =          #colorLiteral(red: 0.7215686275, green: 0.5254901961, blue: 0.0431372549, alpha: 1.0)
  public static let palegoldenrod: RGBColour =          #colorLiteral(red: 0.9333333333, green: 0.9098039216, blue: 0.6666666667, alpha: 1.0)
  public static let khaki: RGBColour =                  #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.5490196078, alpha: 1.0)
  public static let darkkhaki: RGBColour =              #colorLiteral(red: 0.7411764706, green: 0.7176470588, blue: 0.4196078431, alpha: 1.0)
  
  // MARK: - Greens
  public static let chartreuse: RGBColour =             #colorLiteral(red: 0.4980392157, green: 1.0, blue: 0.0, alpha: 1.0)
  public static let lawngreen: RGBColour =              #colorLiteral(red: 0.4862745098, green: 0.9882352941, blue: 0.0, alpha: 1.0)
  public static let limegreen: RGBColour =              #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.1960784314, alpha: 1.0)
  public static let greenyellow: RGBColour =            #colorLiteral(red: 0.6784313725, green: 1.0, blue: 0.1843137255, alpha: 1.0)
  public static let yellowgreen: RGBColour =            #colorLiteral(red: 0.6039215686, green: 0.8039215686, blue: 0.1960784314, alpha: 1.0)
  public static let springgreen: RGBColour =            #colorLiteral(red: 0.0, green: 1.0, blue: 0.4980392157, alpha: 1.0)
  public static let mediumspringgreen: RGBColour =      #colorLiteral(red: 0.0, green: 0.9803921569, blue: 0.6039215686, alpha: 1.0)
  public static let lightgreen: RGBColour =             #colorLiteral(red: 0.5647058824, green: 0.9333333333, blue: 0.5647058824, alpha: 1.0)
  public static let palegreen: RGBColour =              #colorLiteral(red: 0.5960784314, green: 0.9843137255, blue: 0.5960784314, alpha: 1.0)
  public static let aquamarine: RGBColour =             #colorLiteral(red: 0.4980392157, green: 1.0, blue: 0.831372549, alpha: 1.0)
  public static let mediumaquamarine: RGBColour =       #colorLiteral(red: 0.4, green: 0.8039215686, blue: 0.6666666667, alpha: 1.0)
  public static let seagreen: RGBColour =               #colorLiteral(red: 0.1803921569, green: 0.5450980392, blue: 0.3411764706, alpha: 1.0)
  public static let mediumseagreen: RGBColour =         #colorLiteral(red: 0.2352941176, green: 0.7019607843, blue: 0.4431372549, alpha: 1.0)
  public static let lightseagreen: RGBColour =          #colorLiteral(red: 0.1254901961, green: 0.6980392157, blue: 0.6666666667, alpha: 1.0)
  public static let forestgreen: RGBColour =            #colorLiteral(red: 0.1333333333, green: 0.5450980392, blue: 0.1333333333, alpha: 1.0)
  public static let darkseagreen: RGBColour =           #colorLiteral(red: 0.5607843137, green: 0.737254902, blue: 0.5607843137, alpha: 1.0)
  public static let darkolivegreen: RGBColour =         #colorLiteral(red: 0.3333333333, green: 0.4196078431, blue: 0.1843137255, alpha: 1.0)
  public static let olivedrab: RGBColour =              #colorLiteral(red: 0.4196078431, green: 0.5568627451, blue: 0.137254902, alpha: 1.0)
  public static let darkgreen: RGBColour =              #colorLiteral(red: 0.0, green: 0.3921568627, blue: 0.0, alpha: 1.0)
  
  // MARK: - Cyans & Teals
  public static let turquoise: RGBColour =              #colorLiteral(red: 0.2509803922, green: 0.8784313725, blue: 0.8156862745, alpha: 1.0)
  public static let mediumturquoise: RGBColour =        #colorLiteral(red: 0.2823529412, green: 0.8196078431, blue: 0.8, alpha: 1.0)
  public static let darkturquoise: RGBColour =          #colorLiteral(red: 0.0, green: 0.8078431373, blue: 0.8196078431, alpha: 1.0)
  public static let lightcyan: RGBColour =              #colorLiteral(red: 0.8784313725, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let paleturquoise: RGBColour =          #colorLiteral(red: 0.6862745098, green: 0.9333333333, blue: 0.9333333333, alpha: 1.0)
  public static let darkcyan: RGBColour =               #colorLiteral(red: 0.0, green: 0.5450980392, blue: 0.5450980392, alpha: 1.0)
  public static let cadetblue: RGBColour =              #colorLiteral(red: 0.3725490196, green: 0.6196078431, blue: 0.6274509804, alpha: 1.0)
  
  // MARK: - Blues
  public static let dodgerblue: RGBColour =             #colorLiteral(red: 0.1176470588, green: 0.5647058824, blue: 1.0, alpha: 1.0)
  public static let deepskyblue: RGBColour =            #colorLiteral(red: 0.0, green: 0.7490196078, blue: 1.0, alpha: 1.0)
  public static let cornflowerblue: RGBColour =         #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1.0)
  public static let steelblue: RGBColour =              #colorLiteral(red: 0.2745098039, green: 0.5098039216, blue: 0.7058823529, alpha: 1.0)
  public static let royalblue: RGBColour =              #colorLiteral(red: 0.2549019608, green: 0.4117647059, blue: 0.8823529412, alpha: 1.0)
  public static let mediumblue: RGBColour =             #colorLiteral(red: 0.0, green: 0.0, blue: 0.8039215686, alpha: 1.0)
  public static let darkblue: RGBColour =               #colorLiteral(red: 0.0, green: 0.0, blue: 0.5450980392, alpha: 1.0)
  public static let midnightblue: RGBColour =           #colorLiteral(red: 0.0980392157, green: 0.0980392157, blue: 0.4392156863, alpha: 1.0)
  public static let skyblue: RGBColour =                #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9215686275, alpha: 1.0)
  public static let lightskyblue: RGBColour =           #colorLiteral(red: 0.5294117647, green: 0.8078431373, blue: 0.9803921569, alpha: 1.0)
  public static let lightblue: RGBColour =              #colorLiteral(red: 0.6784313725, green: 0.8470588235, blue: 0.9019607843, alpha: 1.0)
  public static let lightsteelblue: RGBColour =         #colorLiteral(red: 0.6901960784, green: 0.768627451, blue: 0.8705882353, alpha: 1.0)
  public static let powderblue: RGBColour =             #colorLiteral(red: 0.6901960784, green: 0.8784313725, blue: 0.9019607843, alpha: 1.0)
  public static let aliceblue: RGBColour =              #colorLiteral(red: 0.9411764706, green: 0.9725490196, blue: 1.0, alpha: 1.0)
  
  // MARK: - Purples & Violets
  public static let indigoWeb: RGBColour =              #colorLiteral(red: 0.2941176471, green: 0.0, blue: 0.5098039216, alpha: 1.0)
  public static let darkviolet: RGBColour =             #colorLiteral(red: 0.5803921569, green: 0.0, blue: 0.8274509804, alpha: 1.0)
  public static let darkmagenta: RGBColour =            #colorLiteral(red: 0.5450980392, green: 0.0, blue: 0.5450980392, alpha: 1.0)
  public static let darkorchid: RGBColour =             #colorLiteral(red: 0.6, green: 0.1960784314, blue: 0.8, alpha: 1.0)
  public static let blueviolet: RGBColour =             #colorLiteral(red: 0.5411764706, green: 0.168627451, blue: 0.8862745098, alpha: 1.0)
  public static let rebeccapurple: RGBColour =          #colorLiteral(red: 0.4, green: 0.2, blue: 0.6, alpha: 1.0)
  public static let mediumpurple: RGBColour =           #colorLiteral(red: 0.5764705882, green: 0.4392156863, blue: 0.8588235294, alpha: 1.0)
  public static let slateblue: RGBColour =              #colorLiteral(red: 0.4156862745, green: 0.3529411765, blue: 0.8039215686, alpha: 1.0)
  public static let mediumslateblue: RGBColour =        #colorLiteral(red: 0.4823529412, green: 0.4078431373, blue: 0.9333333333, alpha: 1.0)
  public static let darkslateblue: RGBColour =          #colorLiteral(red: 0.2823529412, green: 0.2392156863, blue: 0.5450980392, alpha: 1.0)
  public static let violet: RGBColour =                 #colorLiteral(red: 0.9333333333, green: 0.5098039216, blue: 0.9333333333, alpha: 1.0)
  public static let orchid: RGBColour =                 #colorLiteral(red: 0.8549019608, green: 0.4392156863, blue: 0.8392156863, alpha: 1.0)
  public static let mediumorchid: RGBColour =           #colorLiteral(red: 0.7294117647, green: 0.3333333333, blue: 0.8274509804, alpha: 1.0)
  public static let plum: RGBColour =                   #colorLiteral(red: 0.8666666667, green: 0.6274509804, blue: 0.8666666667, alpha: 1.0)
  public static let thistle: RGBColour =                #colorLiteral(red: 0.8470588235, green: 0.7490196078, blue: 0.8470588235, alpha: 1.0)
  public static let lavender: RGBColour =               #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9803921569, alpha: 1.0)
  
  // MARK: - Browns & Earth Tones
  public static let brownWeb: RGBColour =               #colorLiteral(red: 0.6470588235, green: 0.1647058824, blue: 0.1647058824, alpha: 1.0)
  public static let saddlebrown: RGBColour =            #colorLiteral(red: 0.5450980392, green: 0.2705882353, blue: 0.0745098039, alpha: 1.0)
  public static let sienna: RGBColour =                 #colorLiteral(red: 0.6274509804, green: 0.3215686275, blue: 0.1764705882, alpha: 1.0)
  public static let chocolate: RGBColour =              #colorLiteral(red: 0.8235294118, green: 0.4117647059, blue: 0.1176470588, alpha: 1.0)
  public static let peru: RGBColour =                   #colorLiteral(red: 0.8039215686, green: 0.5215686275, blue: 0.2470588235, alpha: 1.0)
  public static let sandybrown: RGBColour =             #colorLiteral(red: 0.9568627451, green: 0.6431372549, blue: 0.3764705882, alpha: 1.0)
  public static let rosybrown: RGBColour =              #colorLiteral(red: 0.737254902, green: 0.5607843137, blue: 0.5607843137, alpha: 1.0)
  public static let tan: RGBColour =                    #colorLiteral(red: 0.8235294118, green: 0.7058823529, blue: 0.5490196078, alpha: 1.0)
  public static let burlywood: RGBColour =              #colorLiteral(red: 0.8705882353, green: 0.7215686275, blue: 0.5294117647, alpha: 1.0)
  public static let wheat: RGBColour =                  #colorLiteral(red: 0.9607843137, green: 0.8705882353, blue: 0.7019607843, alpha: 1.0)
  public static let navajowhite: RGBColour =            #colorLiteral(red: 1.0, green: 0.8705882353, blue: 0.6784313725, alpha: 1.0)
  public static let bisque: RGBColour =                 #colorLiteral(red: 1.0, green: 0.8941176471, blue: 0.768627451, alpha: 1.0)
  public static let moccasin: RGBColour =               #colorLiteral(red: 1.0, green: 0.8941176471, blue: 0.7098039216, alpha: 1.0)
  public static let peachpuff: RGBColour =              #colorLiteral(red: 1.0, green: 0.8549019608, blue: 0.7254901961, alpha: 1.0)
  
  // MARK: - Whites & Off-Whites
  public static let ivory: RGBColour =                  #colorLiteral(red: 1.0, green: 1.0, blue: 0.9411764706, alpha: 1.0)
  public static let lightyellow: RGBColour =            #colorLiteral(red: 1.0, green: 1.0, blue: 0.8784313725, alpha: 1.0)
  public static let lightgoldenrodyellow: RGBColour =   #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.8235294118, alpha: 1.0)
  public static let lemonchiffon: RGBColour =           #colorLiteral(red: 1.0, green: 0.9803921569, blue: 0.8039215686, alpha: 1.0)
  public static let cornsilk: RGBColour =               #colorLiteral(red: 1.0, green: 0.9725490196, blue: 0.862745098, alpha: 1.0)
  public static let papayawhip: RGBColour =             #colorLiteral(red: 1.0, green: 0.937254902, blue: 0.8352941176, alpha: 1.0)
  public static let blanchedalmond: RGBColour =         #colorLiteral(red: 1.0, green: 0.9215686275, blue: 0.8039215686, alpha: 1.0)
  public static let antiquewhite: RGBColour =           #colorLiteral(red: 0.9803921569, green: 0.9215686275, blue: 0.8431372549, alpha: 1.0)
  public static let beige: RGBColour =                  #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1.0)
  public static let oldlace: RGBColour =                #colorLiteral(red: 0.9921568627, green: 0.9607843137, blue: 0.9019607843, alpha: 1.0)
  public static let floralwhite: RGBColour =            #colorLiteral(red: 1.0, green: 0.9803921569, blue: 0.9411764706, alpha: 1.0)
  public static let linen: RGBColour =                  #colorLiteral(red: 0.9803921569, green: 0.9411764706, blue: 0.9019607843, alpha: 1.0)
  public static let lavenderblush: RGBColour =          #colorLiteral(red: 1.0, green: 0.9411764706, blue: 0.9607843137, alpha: 1.0)
  public static let mistyrose: RGBColour =              #colorLiteral(red: 1.0, green: 0.8941176471, blue: 0.8823529412, alpha: 1.0)
  public static let seashell: RGBColour =               #colorLiteral(red: 1.0, green: 0.9607843137, blue: 0.9333333333, alpha: 1.0)
  public static let snow: RGBColour =                   #colorLiteral(red: 1.0, green: 0.9803921569, blue: 0.9803921569, alpha: 1.0)
  public static let honeydew: RGBColour =               #colorLiteral(red: 0.9411764706, green: 1.0, blue: 0.9411764706, alpha: 1.0)
  public static let mintcream: RGBColour =              #colorLiteral(red: 0.9607843137, green: 1.0, blue: 0.9803921569, alpha: 1.0)
  public static let azure: RGBColour =                  #colorLiteral(red: 0.9411764706, green: 1.0, blue: 1.0, alpha: 1.0)
  public static let ghostwhite: RGBColour =             #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1.0, alpha: 1.0)
  public static let whitesmoke: RGBColour =             #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1.0)
  
  // MARK: - Grays
  public static let gainsboro: RGBColour =              #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1.0)
  public static let lightgray: RGBColour =              #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1.0)
  public static let darkgray: RGBColour =               #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1.0)
  public static let dimgray: RGBColour =                #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1.0)
  public static let lightslategray: RGBColour =         #colorLiteral(red: 0.4666666667, green: 0.5333333333, blue: 0.6, alpha: 1.0)
  public static let slategray: RGBColour =              #colorLiteral(red: 0.4392156863, green: 0.5019607843, blue: 0.5647058824, alpha: 1.0)
  public static let darkslategray: RGBColour =          #colorLiteral(red: 0.1843137255, green: 0.3098039216, blue: 0.3098039216, alpha: 1.0)
  
}
