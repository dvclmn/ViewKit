//
//  Model+ColourLevel.swift
//  Paperbark
//
//  Created by Dave Coleman on 29/6/2025.
//

//import CoreTools

import SwiftUI

//public protocol ColourHandlerProtocol {
//  var foregroundRGB: RGBColour { get set }
//  var backgroundRGB: RGBColour { get set }
//
//  var foreground: Color { get }
//  var background: Color { get }
//}

//@CaseDetection
/// I don't at all understand the relationship between
/// `HierarchicalColour` and `ColourLevel`
public enum HierarchicalColour: String, Sendable, CaseCyclable, CaseIterable, NamedItem, Identifiable,
  Equatable
{

  public static let defaultCase: Self = .primary

  case primary  // Foreground by default
  case secondary  // Background by default

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }

  public func colour(for activeLevel: ColourLevel) -> Self {
    switch activeLevel {
      case .foreground: .primary
      case .background: .secondary
    }
  }

  static func slot(for level: ColourLevel, foregroundSlot: HierarchicalColour) -> HierarchicalColour {
    switch level {
      case .foreground: return foregroundSlot
      case .background: return foregroundSlot == .primary ? .secondary : .primary
    }

  }
}

public enum ColourLevel: String, Sendable, CaseCyclable, CaseIterable, NamedItem, Pickable, Identifiable {
  public typealias Item = Self

  public static let defaultCase: ColourLevel = .foreground

  case foreground
  case background

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }

  public var isForeground: Bool { self == .foreground }
  public var isBackground: Bool { self == .background }
}

extension Binding where Value == RGBColour {

  public static func dualColourBinding(
    _ primary: Binding<RGBColour>,
    _ secondary: Binding<RGBColour?>,
    level: ColourLevel
  ) -> Binding<RGBColour> {
    Binding<RGBColour> {

      if level.isForeground {
        return primary.wrappedValue
      }

      guard let secondary = secondary.wrappedValue else {
        return primary.wrappedValue
      }

      return secondary

    } set: {
      if level.isForeground {
        primary.wrappedValue = $0
      } else {
        secondary.wrappedValue = $0
      }
    }
  }
}

extension ColourLevel: CustomStringConvertible {
  public var description: String { name }
}

extension ColourLevel {

//  public func keyPathRGB<T: ColourHandlerProtocol>() -> WritableKeyPath<T, RGBColour> {
//    switch self {
//      case .foreground: \.foregroundRGB
//      case .background: \.backgroundRGB
//    }
//  }

  //  public func label(_ thing: () -> String) {
  //
  //  }
  //  public func keyPathHSV<T: ColourHandlerProtocol>() -> KeyPath<T, HSVColour> {
  //    switch self {
  //      case .foreground: \.foregroundHSV
  //      case .background: \.backgroundHSV
  //    }
  //  }
//  public func keyPathSwiftUI<T: ColourHandlerProtocol>() -> KeyPath<T, Color> {
//    switch self {
//      case .foreground: \.foreground
//      case .background: \.background
//    }
//  }
  //  public var keyPathSelected: KeyPath<ColourHandler, Self> {
  //    return \.activeColourLevel
  //    //    switch self {
  //    //      case .foreground:
  //    //      case .background: \.background
  //    //    }
  //  }

  //  public var isForeground: Bool {
  //    return self == .foreground
  //  }
  //  public func isSelected(_ handler: ColourHandler) -> Bool {
  //    return self == handler[keyPath: keyPathSelected]
  //  }
}
