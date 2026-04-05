//
//  TextAttributes.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/12/2025.
//

//import AppKit

//
//public struct TextAttributes {
//  private var storage: [NSAttributedString.Key: Any]
//
//  public init() {
//    self.storage = [:]
//  }
//}
//extension TextAttributes {

//  private func anyKey(for key: NSAttributedString.Key) -> AnyAttributeKey.Meta? {
////    switch key {
////      case .foregroundColor: .foreground
////      case .font: .font
////      case .fontTraits: .fontTraits
////      case .strikethroughStyle: .strikeStyle
////      case .strikethroughColor: .strikeColour
////        
//////      default: nil
////    }
//  }
//  private func anyKey<T>(for key: AttributeKey<T>) -> AnyAttributeKey.Meta? {
//    let nsKey = key.nsKey
//    return self.anyKey(for: nsKey)
//    //    switch key {
//    //      case AttributeKey<T>.foregroundColor: AnyAttributeKey.Meta.fore
//    //      case .font: AnyAttributeKey.Meta.font
//    //      case .fontTraits: AnyAttributeKey.Meta.fontTraits
//    //      case .codeBackground: AnyAttributeKey.Meta.codeBackground
//    //    }
//  }
//}

//extension TextAttributes {
//  public subscript<Value>(key: AttributeKey<Value>) -> Value? {
//    get {
//      //      guard let typedKey = self.anyKey(for: key) else { return nil }
//      //      return typedStorage[typedKey]?[key.nsKey] as? Value
//      storage[key.nsKey] as? Value
//    }
//    set {
//      //      guard let typedKey = self.anyKey(for: key) else { return }
//      //      typedStorage[typedKey]?[key.nsKey] = newValue
//      storage[key.nsKey] = newValue
//    }
//  }
//
//  //  public func getFont(with currentFont: NSFont, scale: CGFloat = 1.0) -> NSFont? {
//  //
//  //    let traits = typedStorage[.fontTraits]
//  //    //    get {
//  ////    let traits = storage[.fontTraits] as? FontTraits
//  //    return traits?.constructFont(font: currentFont, sizeScale: scale)
//  //    //    }
//  //    //    set {
//  //
//  //    //    }
//  //  }
//
//  public var toNSAttributes: NSTextAttributes {
//    self.storage
//  }
//}

//extension NSTextAttributes {
//  public var toTextAttributes: TextAttributes? {
//    var result = TextAttributes()
//    for (key, value) in self {
//      
////      switch key {
////
////        case AttributeKey<NSColor>.foregroundColor.nsKey:
////          guard let v = value as? NSColor else { return nil }
////          result[.foregroundColor] = v
////
////        case AttributeKey<NSFont>.font.nsKey:
////          guard let v = value as? NSFont else { return nil }
////          result[.font] = v
////
////        case AttributeKey<FontTraits>.fontTraits.nsKey:
////          guard let v = value as? FontTraits else { return nil }
////          result[.fontTraits] = v
////
////        //        case AttributeKey<CodeBackground>.codeBackground.nsKey:
////        //          guard let v = value as? CodeBackground else { return nil }
////        //          result[.codeBackground] = v
////
////        default:
////          // Ignore unknown keys
////          print("Encountered unknown key: \(key), not adding to result")
////          continue
////      }
//    }
//    return result
//  }
//}
//extension TextAttributes: CustomStringConvertible {
//  public var description: String {
//    var parts: [String] = []
//    if let color = self[.foregroundColor] { parts.append("foregroundColor = \(color.accessibilityName)") }
//    if let font = self[.font] { parts.append("font = \(font.prettyDescription)") }
//    if let traits = self[.fontTraits] { parts.append("fontTraits = \(traits)") }
//
//    return parts.joined(separator: "\n")
//    //    return "TextAttributes{\n  " + parts.joined(separator: "\n  ") + "\n}"
//  }
//}

