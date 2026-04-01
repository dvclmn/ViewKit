//
//  Model+SplineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/5/2025.
//

//import CoreTools

//import Foundation

//public enum CatmullRom {}

//extension CatmullRom {

  /// The value of α determines how much the physical distance between points affects the "speed" of the curve
  ///
  /// ## Uniform (α=0)
  /// The distance between points doesn't matter. The transition from P1 to P2 takes the
  /// same "time" as P3 to P4, even if one gap is 10x wider.
  ///
  /// ## Centripetal (α=0.5)
  /// This is the "Goldilocks" zone. It follows the square root of the distance. It is mathematically
  /// guaranteed to prevent "cusps" (sharp loops or self-intersections) when points are close together.
  ///
  /// ## Chordal (α=1.0)
  /// The time taken is exactly proportional to the linear distance between points.
  /// This tends to produce very wide, sweeping curves.
  ///
  /// In short: Alpha handles the geometry of the path (preventing loops), while tension handles the stiffness of the path.
//  public enum SplineVariant: String, Pickable, Codable, Sendable, CaseIterable, Identifiable {
//    case uniform
//    case centripetal
//    case chordal
//    public var id: String { rawValue }
//    public static var pickerLabel: QuickLabel { "Catmull-Rom Type" }
//  }
//}

//extension CatmullRom.SplineVariant {
//
//  public var alpha: CGFloat {
//    switch self {
//      case .uniform: 0
//      case .centripetal: 0.5
//      case .chordal: 1
//    }
//  }
//  public var name: String { self.rawValue.capitalized }
//
//  public var icon: String {
//    switch self {
//      case .uniform: "eye"
//      case .chordal: "eye"
//      case .centripetal: "eye"
//    //      case .none: "eye"
//    }
//  }
//}
