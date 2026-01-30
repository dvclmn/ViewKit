//
//  Model+SplineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/5/2025.
//

import CoreTools
import Foundation

public enum CatmullRom {}

extension CatmullRom {

  /// The type of Catmull-Rom parameterization to use
  public enum SplineVariant: String, Pickable, Codable, Sendable {
    case uniform // Tensor-based. Fastest?
    case centripetal
    case chordal

    public static var pickerLabel: QuickLabel { "Catmull-Rom Type" }
  }
}

extension CatmullRom.SplineVariant {

  public var name: String { self.rawValue.capitalized }

  public var icon: String {
    switch self {
      case .uniform: "eye"
      case .chordal: "eye"
      case .centripetal: "eye"
      case .none: "eye"
    }
  }
}
