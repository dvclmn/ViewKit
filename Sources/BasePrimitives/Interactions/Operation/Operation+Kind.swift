//
//  Operation+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

//extension CanvasOperation {
//  /// An extensible operation identity — same pattern as `CanvasToolKind`.
//  ///
//  /// Extend in your domain:
//  /// ```swift
//  /// extension CanvasOperation.Kind {
//  ///   public static let placingText = Self(rawValue: "placingText")
//  /// }
//  /// ```
//  public struct Kind: RawRepresentable, Hashable, Sendable {
//    public let rawValue: String
//    public init(rawValue: String) { self.rawValue = rawValue }
//  }
//}
//
//extension CanvasOperation.Kind {
//  public static let idle = Self(rawValue: "idle")
//  public static let hovering = Self(rawValue: "hovering")
//  public static let selecting = Self(rawValue: "selecting")
//  public static let panning = Self(rawValue: "panning")
//  public static let zooming = Self(rawValue: "zooming")
//}
//
//extension CanvasOperation.Kind {
//  public var name: String { rawValue.capitalized }
//}
