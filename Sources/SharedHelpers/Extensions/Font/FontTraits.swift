//
//  FontTraits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/12/2025.
//

import AppKit

extension NSFontDescriptor.SymbolicTraits: @retroactive Hashable {}

/// Bit easier having this custom type, than always trying to
/// conform `NSFontDescriptor.SymbolicTraits` to hashable etc
public struct FontTraits: Hashable, Sendable {
  let traits: NSFontDescriptor.SymbolicTraits
}

extension FontTraits {
  public init?(
    _ traits: NSFontDescriptor.SymbolicTraits?,
  ) {
    guard let traits else { return nil }
    self.init(traits: traits)
  }

  public func constructFont(
    font: NSFont,
    sizeScale: CGFloat
  ) -> NSFont? {
    self.traits.constructFont(from: font, scale: sizeScale)
  }
}

extension FontTraits: CustomStringConvertible {
  public var description: String {
    return self.traits.prettyDescription
  }

}
extension NSFontDescriptor.SymbolicTraits {
  
  public var prettyDescription: String {
    let parts = boldItalicDescription
    + traitDescriptions
    
    return "[" + parts.joined(separator: ", ") + "]"
  }
  
  private var boldItalicDescription: [String] {
    switch (contains(.bold), contains(.italic)) {
      case (true, true):   return ["Bold Italic"]
      case (true, false):  return ["Bold"]
      case (false, true):  return ["Italic"]
      case (false, false): return []
    }
  }
  
  private var traitDescriptions: [String] {
    [
      (Self.expanded,      "Expanded"),
      (Self.condensed,     "Condensed"),
      (Self.monoSpace,     "Monospaced"),
      (Self.vertical,      "Vertical"),
      (Self.UIOptimized,   "UI Optimized"),
      (Self.tightLeading,  "Tight Leading"),
      (Self.looseLeading,  "Loose Leading")
    ]
      .compactMap { contains($0.0) ? $0.1 : nil }
  }
  
//  public var prettyDescription: String {
//    let isBold = self.contains(.bold)
//    let isItalic = self.contains(.italic)
//
//    var desc: [String] = []
//
//    
//    if isBold && isItalic {
//      desc.append("Bold Italic")
//    } else {
//      if isBold {
//        desc.append("Bold")
//      }
//      if isItalic {
//        desc.append("Italic")
//      }
//    }
//    
////    switch self {
////      case let t where t.contains([.bold, .italic]):
//////      case let t where t.contains([.bold, .italic]):
////        // Both bold and italic are present
////      case let t where t.contains(.bold):
////        // Only bold is present
////      case let t where t.contains(.italic):
////        // Only italic is present
////      default:
////        // Neither
////    }
//
//
//    if self.contains(.expanded) {
//      desc.append("Expanded")
//    }
//    if self.contains(.condensed) {
//      desc.append("Condensed")
//    }
//    if self.contains(.monoSpace) {
//      desc.append("Monospaced")
//    }
//    if self.contains(.vertical) {
//      desc.append("Vertical")
//    }
//    if self.contains(.UIOptimized) {
//      desc.append("UI Optimized")
//    }
//    if self.contains(.tightLeading) {
//      desc.append("Tight Leading")
//    }
//    if self.contains(.looseLeading) {
//      desc.append("Loose Leading")
//    }
//    
//
//    return "[" + desc.joined(separator: ", ") + "]"
//  }
}
