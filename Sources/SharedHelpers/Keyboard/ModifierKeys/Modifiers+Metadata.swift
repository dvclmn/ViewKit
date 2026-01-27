//
//  Modifiers+Metadata.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import Foundation

extension ModifierKeys.Options {
  public var id: Int { rawValue }
  
  public var name: String {
    switch self {
      case .shift: "Shift"
      case .option: "Option"
      case .command: "Command"
      case .control: "Control"
      case .capsLock: "Caps Lock"
    }
  }
  
  public var symbolLiteral: Character {
    switch self {
      case .shift: "􀆝"
      case .option: "􀆕"
      case .command: "􀆔"
      case .control: "􀆍"
      case .capsLock: "􀆡"
    }
  }
}

extension Modifiers {
  #warning("Bring this back, just fiddling with modifiers")
  //  public func displayName(
  //    elements: ModifierDisplayElement,
  //    separator: String = " + ",
  //    emptyText: String = "None"
  //  ) -> String {
  //    let components: [String] = self.compactMap { option in
  //      guard let meta = ModifierKeys.metadata[option] else { return nil }
  //
  //      switch elements {
  //        case .name:
  //          return meta.name
  //        case .icon:
  //          return meta.symbol
  //        case .both:
  //          return "\(meta.symbol) \(meta.name)"
  //        default:
  //          return nil
  //      }
  //    }
  //
  //    return components.isEmpty ? emptyText : components.joined(separator: separator)
  //  }
}
extension ModifierKeys: CustomStringConvertible {
  public var description: String {
    #warning("Bring this back, just fiddling with modifiers")
    //    displayName(elements: .name)
    self.stringValueJoined()
  }
}
