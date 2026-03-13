//
//  Operation+Kind.swift
//  DrawString
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

extension CanvasOperation {
  public struct Kind: RawRepresentable, Hashable, Sendable {
    public let rawValue: String
    public init(rawValue: String) { self.rawValue = rawValue }
  }
}

extension CanvasOperation.Kind {
  public static let idle = Self(rawValue: "idle")
  public static let hovering = Self(rawValue: "hovering")
  public static let selecting = Self(rawValue: "selecting")
  public static let panning = Self(rawValue: "panning")
  public static let zooming = Self(rawValue: "zooming")
}

extension CanvasOperation.Kind {
  var name: String { rawValue.capitalized }
}


//extension CanvasOperation {
//  enum Kind: Equatable, Sendable {
//    case selecting(SelectionMode)
//    case panning(TransformSource)
//    case zooming(TransformSource)
//    case placingText
//  }
//}
//
//extension CanvasOperation.Kind {
//  var name: String {
//    switch self {
//      case .selecting(let mode): "Selecting (\(mode.name))"
//      case .panning(let source): "Panning via " + source.name
//      case .zooming(let source): "Zooming via " + source.name
//      case .placingText: "Placing Text"
//    }
//  }
//}
//
