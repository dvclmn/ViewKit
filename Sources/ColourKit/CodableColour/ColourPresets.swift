//
//  ColourPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/11/2025.
//

//
extension CodableColour {
  /// Handy presets to get straight to a system colour
  public static let red: Self = .system(.red)
  public static let orange: Self = .system(.orange)
  public static let yellow: Self = .system(.yellow)
  public static let green: Self = .system(.green)
  public static let mint: Self = .system(.mint)
  public static let teal: Self = .system(.teal)
  public static let cyan: Self = .system(.cyan)
  public static let blue: Self = .system(.blue)
  public static let indigo: Self = .system(.indigo)
  public static let purple: Self = .system(.purple)
  public static let pink: Self = .system(.pink)
  public static let brown: Self = .system(.brown)
  public static let white: Self = .system(.white)
  public static let gray: Self = .system(.gray)
  public static let black: Self = .system(.black)
  public static let clear: Self = .system(.clear)
  public static let primary: Self = .system(.primary)
  public static let secondary: Self = .system(.secondary)
  public static let tertiary: Self = .system(.tertiary)
  public static let quaternary: Self = .system(.quaternary)
  public static let quinary: Self = .system(.quinary)
  public static let accentColor: Self = .system(.accentColor)
  public static let link: Self = .system(.link)

  static var olive: Self {
    Colour.hsvRaw(
      h: 0.34,
      s: 0.17,
      v: 0.2
    )
  }

  static var reddish: Self {
    Colour.hsvRaw(
      h: 0.02,
      s: 0.69,
      v: 0.82
    )
  }
}
