//
//  ASCIIColours.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

public enum ASCIIColour: String {
  case asciiAmber
  case asciiBlack
  case asciiBlue
  case asciiBrightBlue
  case asciiBrightGreen
  case asciiBrightPurple
  case asciiBrightRed
  case asciiBrightTeal
  case asciiBrown
  case asciiDarkGrey
  case asciiGreen
  case asciiLightGrey
  case asciiOffBlack
  case asciiPhosphor
  case asciiPurple
  case asciiRed
  case asciiTeal
  case asciiWhite
  case asciiYellow

  public var colour: Color {
    Color(rawValue, bundle: .module)
//    Color("asciiColour/" + self.rawValue, bundle: .module)
  }
}

//asciiAmber.colorset
//asciiBlack.colorset
//asciiBlue.colorset
//asciiBrightBlue.colorset
//asciiBrightGreen.colorset
//asciiBrightPurple.colorset
//asciiBrightRed.colorset
//asciiBrightTeal.colorset
//asciiBrown.colorset
//asciiDarkGrey.colorset
//asciiGreen.colorset
//asciiLightGrey.colorset
//asciiOffBlack.colorset
//asciiPhosphor.colorset
//asciiPurple.colorset
//asciiRed.colorset
//asciiTeal.colorset
//asciiWhite.colorset
//asciiYellow.colorset
