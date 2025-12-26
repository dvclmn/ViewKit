//
//  TextAttributes.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/12/2025.
//

import AppKit
import SharedHelpers

public struct TextAttributes {

  private var typedStorage: [AnyAttributeKey.Meta: NSTextAttributes]
  //  private var storage: [NSAttributedString.Key: Any]

  public init() {
    self.typedStorage = [:]
    //    self.storage = [:]
  }
}
extension TextAttributes {
  //  subscript(key: AnyAttributeKey.Meta) -> NSTextAttributes? {
  //    get {
  //      typedStorage[key]
  //    }
  //    set {
  //      typedStorage[key] = newValue
  //    }
  //  }

  private func anyKey(for key: NSAttributedString.Key) -> AnyAttributeKey.Meta? {
    switch key {
      case .foregroundColor: .fore
      case .font: .font
      case .fontTraits: .fontTraits
      case .codeBackground: .codeBackground
      default: nil
    }
  }
  private func anyKey<T>(for key: AttributeKey<T>) -> AnyAttributeKey.Meta? {
    
  }
}

extension TextAttributes {
  public subscript<Value>(key: AttributeKey<Value>) -> Value? {
    get {
      guard let typedKey = self.anyKey(for: <#T##NSAttributedString.Key#>)
      typedStorage[]
      //      storage[key.nsKey] as? Value
    }
    set {
      storage[key.nsKey] = newValue
    }
  }

  public func getFont(with currentFont: NSFont, scale: CGFloat = 1.0) -> NSFont? {
    //    get {
    let traits = storage[.fontTraits] as? FontTraits
    return traits?.constructFont(font: currentFont, sizeScale: scale)
    //    }
    //    set {

    //    }
  }

  public var toNSAttributes: NSTextAttributes {

    //    self.storage
  }
}



extension NSTextAttributes {
  public var toTextAttributes: TextAttributes? {
    var result = TextAttributes()
    for (key, value) in self {
      switch key {

        case AttributeKey<NSColor>.foregroundColor.nsKey:
          guard let v = value as? NSColor else { return nil }
          result[.foregroundColor] = v

        case AttributeKey<NSFont>.font.nsKey:
          guard let v = value as? NSFont else { return nil }
          result[.font] = v

        case AttributeKey<FontTraits>.fontTraits.nsKey:
          guard let v = value as? FontTraits else { return nil }
          result[.fontTraits] = v

        case AttributeKey<CodeBackground>.codeBackground.nsKey:
          guard let v = value as? CodeBackground else { return nil }
          result[.codeBackground] = v

        default:
          // Ignore unknown keys
          print("Encountered unknown key: \(key), not adding to result")
          continue
      }
    }
    return result
  }
}
extension TextAttributes: CustomStringConvertible {
  public var description: String {
    var parts: [String] = []
    if let color = self[.foregroundColor] { parts.append("foregroundColor=\(color)") }
    if let font = self[.font] { parts.append("font=\(font)") }
    if let traits = self[.fontTraits] { parts.append("fontTraits=\(traits)") }
    if let background = self[.codeBackground] { parts.append("codeBackground=\(background)") }
    // Include any unknown keys for debugging (optional)
    let knownKeys: Set = [
      AttributeKey<NSColor>.foregroundColor.nsKey,
      AttributeKey<NSFont>.font.nsKey,
      AttributeKey<FontTraits>.fontTraits.nsKey,
      AttributeKey<CodeBackground>.codeBackground.nsKey,
    ]
    let unknowns = storage.filter { !knownKeys.contains($0.key) }
    for (key, value) in unknowns {
      parts.append("\(key.rawValue)=\(value)")
    }
    return "TextAttributes{" + parts.joined(separator: ", ") + "}"
  }
}
