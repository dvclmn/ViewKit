//
//  System+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import SwiftUI

extension SystemColour {

  public init?(colour: Color) {
    guard
      let match = Self.allCases.first(where: { $0.toColour == colour })
    else {
      return nil
    }
    self = match
  }

//  public func resolve(in env: EnvironmentValues) -> Color {
//    let colour = self.toColour
//    return colour.resolve(in: env)
//  }

  public var toColour: Color {
    switch self {
      case .red: Color.red
      case .orange: Color.orange
      case .yellow: Color.yellow
      case .green: Color.green
      case .mint: Color.mint
      case .teal: Color.teal
      case .cyan: Color.cyan
      case .blue: Color.blue
      case .indigo: Color.indigo
      case .purple: Color.purple
      case .pink: Color.pink
      case .brown: Color.brown
      case .white: Color.white
      case .gray: Color.gray
      case .black: Color.black
      case .clear: Color.clear
      case .primary: Color.primary
      case .secondary: Color.secondary
      case .tertiary: Color(NSColor.tertiaryLabelColor)
      case .quaternary: Color(NSColor.quaternaryLabelColor)
      case .quinary: Color(NSColor.quaternaryLabelColor.opacity(0.5))
      case .accentColor: Color.accentColor
      case .link: Color(NSColor.linkColor)
    }
  }

}
