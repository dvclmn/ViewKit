//
//  ActionLineParameter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

public enum ActionLineParameter: Identifiable, CaseIterable {
  
  case outerRadius
  case outerVariation
  case innerRadius
  case innerVariation
  
  case density
  case lineWidth
  
  case radialCoverage
  case rotation
  
  public var id: String { self.name }
  
  public var name: String {
    switch self {
      case .outerRadius: "Outer Radius"
      case .outerVariation: "Outer Variation"
      case .innerRadius: "Inner Radius"
      case .innerVariation: "Inner Variation"
        
      case .density: "Density"
      case .lineWidth: "Line Width"
        
      case .radialCoverage: "Radial Coverage"
      case .rotation: "Rotation"
    }
  }
  
  public var range: ClosedRange<Double> {
    switch self {
        
        /// Going to keep the lower bound at `0`, as I dont feel the 'wrapping in on itself' effect is useful,
        /// at the moment. However having the upper bound above `1` allows the inner radius to
        /// become an outer radius, which *is* a lot of fun to experiment with.
      case .outerRadius: 0...4
      case .innerRadius: 0...4
      case .density: 0.5...1600
      case .radialCoverage: 0...1
      case .outerVariation: 0...2
      case .innerVariation: 0...2
      case .rotation: 0...359.99
      case .lineWidth: 0.02...160
    }
  }
  
  public var keyPath: WritableKeyPath<ActionLineConfigurations, Double> {
    switch self {
      case .outerRadius: \ActionLineConfigurations.outerShape.radius
      case .innerRadius: \ActionLineConfigurations.innerShape.radius
      case .density: \ActionLineConfigurations.density
      case .radialCoverage: \ActionLineConfigurations.radialCoverage
      case .outerVariation: \ActionLineConfigurations.outerShape.variation
      case .innerVariation: \ActionLineConfigurations.innerShape.variation
      case .rotation: \ActionLineConfigurations.rotationDegrees
      case .lineWidth: \ActionLineConfigurations.lineStyle.width
    }
  }
}

