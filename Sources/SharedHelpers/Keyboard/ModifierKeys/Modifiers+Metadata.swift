//
//  Modifiers+Metadata.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import Foundation

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
