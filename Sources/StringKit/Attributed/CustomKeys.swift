//
//  CustomKeys.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/12/2025.
//

import AppKit

extension String {
  public static var fontTraitsKey: String { "fontTraits" }
  
}
extension NSAttributedString.Key {
  public static let fontTraits = NSAttributedString.Key(String.fontTraitsKey)
}
