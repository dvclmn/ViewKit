//
//  ActionLineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import ColourKit
import CoreGraphics
import SwiftUI
import CoreTools
import CasePaths

/// Ideas for future properties:
/// - capStyle
extension ActionLine {

  public struct BoundaryStyle: Equatable, Sendable, Codable {

    public var radius: Double
    public var position: CGPoint

    /// A randomised value controlling visual 'rag' quality,
    /// for boundary action line edges?
    public var variation: Double
    public var colour: HSVColour
    public var shape: BoundaryShape

    public init(
      radius: Double = 0.5,
      position: CGPoint = .zero,
      variation: Double = 1,
      colour: HSVColour = .gray(0.5),
      shape: BoundaryShape = .circle
    ) {
      self.radius = radius
      self.position = position
      self.variation = variation
      self.colour = colour
      self.shape = shape
    }
  }
}

extension ActionLine {
  @CaseDetection
//  @CasePathable
//  @dynamicMemberLookup
  public enum BoundaryKind: String, CaseIterable, Identifiable, NamedItem {
    case inner
    case outer
    
    public var id: String { rawValue }
    public var name: String { rawValue.capitalized }
    
    public var path: WritableKeyPath<ActionLine.Configuration, BoundaryStyle> {
//    public var path: ReferenceWritableKeyPath<ActionLine.Configuration, BoundaryStyle> {
//    public var path: ReferenceWritableKeyPath<Binding<ActionLine.Configuration>, BoundaryStyle> {
//    public var path: WritableKeyPath<Binding<ActionLine.Configuration>, BoundaryStyle> {
      switch self {
        case .inner: \.innerShape
        case .outer: \.outerShape
      }
    }
  }
}
