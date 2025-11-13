//
//  Box+Fallbacks.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

extension Character {
//  public static var blank: Character { "+" }
  public static var blank: Character { " " }
}

extension Box {
  public static var glyphSetCharacterFallback: Character { "?" }
  public static var paddingCharacterFallback: Character { " " } // &
}
