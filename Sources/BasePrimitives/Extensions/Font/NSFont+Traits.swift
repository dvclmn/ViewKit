//
//  NSFont+Traits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

//import AppKit
//import EnumMacros

//extension NSFont {
//
//  @SetOfOptions<Int>
//  struct Traits {
//    enum Options: Int {
//      case italic
//      case bold
//      case semiBold
//      case monospace
//      case rounded
//    }
//  }
//}
//
//extension NSFont.Traits.Options {
//  var toSymbolicTraits: NSFontDescriptor.SymbolicTraits? {
//    switch self {
//      case .italic: .italic
//      case .bold: .bold
//      case .semiBold: nil
//      case .monospace: .monoSpace
//      case .rounded: nil
//    }
//  }
//  
//  
//}

//  public var prettyDescription: String {
//    var desc: [String] = []
//    if self.contains(.bold) {
//      desc += ["Bold"]
//    }
//    if self.contains(.italic) {
//      desc += ["Italic"]
//    }
//    if self.contains(.condensed) {
//      desc += ["Condensed"]
//    }
//    if self.contains(.expanded) {
//      desc += ["Expanded"]
//    }
//    if self.contains(.monoSpace) {
//      desc += ["Monospace"]
//    } else {
//      desc += [String(describing: self)]
//    }
//
//    guard !desc.isEmpty else {
//      return "No traits"
//    }
//    return desc.joined(separator: ", ")
//  }
//
