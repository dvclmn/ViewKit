//
//  CatmullToSort.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools

public enum CatmullRomTypeMetadata: String, Pickable, Codable, Sendable {
  public static var pickerLabel: QuickLabel { .init("Catmull-Rom Type") }
  
  case uniform
  case chordal
  case centripetal
  case none
  
  public var name: String { self.rawValue.capitalized }
  
  public var toSplineType: CatmullRomType? {
    switch self {
      case .uniform: .uniform
      case .chordal: .chordal
      case .centripetal: .centripetal
      default: nil
    }
  }
  
  public var icon: String {
    switch self {
      case .uniform: "eye"
      case .chordal: "eye"
      case .centripetal: "eye"
      case .none: "eye"
    }
  }
}
