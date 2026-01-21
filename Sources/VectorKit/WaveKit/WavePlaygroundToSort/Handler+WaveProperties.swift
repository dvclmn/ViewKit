//
//  Handler+WaveProperties.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/8/2025.
//


import IdentifiedCollections
import SwiftUI




//extension IdentifiedArray where Element == Wave, Element.ID == Wave.ID {
//  //extension Dictionary where Key: CaseIterable, Value == SmoothedProperty {
//  public mutating func updateAll(
//    dt: CGFloat,
//    timeConstant: CGFloat
//  ) {
//    for element in self.elements {
//
//      //      self[id: element.id]?.amplitude.update(dt: dt, timeConstant: timeConstant)
//    }
//  }
//}

//@MainActor
//public struct WaveProperties: Sendable, Equatable {
//  //  public var engine = Engine()
//  //  public var shape = Shape()
//  //
//  //  public init() {}
//
//  public var engine: [WaveEngineProperty: SmoothedProperty]
//  public var shape: [WaveShapeProperty: SmoothedProperty]
//
//  public init() {
//    engine = Dictionary(uniqueKeysWithValues: WaveEngineProperty.allCases.map { ($0, .init($0.defaultValue)) })
//    shape = Dictionary(uniqueKeysWithValues: WaveShapeProperty.allCases.map { ($0, .init($0.defaultValue)) })
//  }
//}

//extension WaveProperties {
//  // MARK: - Engine domain
//  /// The oscillating CGFloat wave value, used to drive animated effects
//  //  @MainActor
//  public struct Engine: Sendable, Equatable {
//    public var targetAmplitude: CGFloat = WaveEngineProperty.amplitude.defaultValue
//    public var targetFrequency: CGFloat = WaveEngineProperty.frequency.defaultValue
//    public var targetNoise: CGFloat = WaveEngineProperty.noise.defaultValue
//    public var targetPhaseOffset: CGFloat = WaveEngineProperty.phaseOffset.defaultValue
//
//    public var displayedAmplitude: CGFloat = .zero
//    public var displayedFrequency: CGFloat = .zero
//    public var displayedNoise: CGFloat = .zero
//    public var displayedPhaseOffset: CGFloat = .zero
//  }
//
//  // MARK: - Shape domain
//  /// How the wave is drawn to the Canvas, for visualisation in the UI
//  //  @MainActor
//  public struct Shape: Sendable, Equatable {
//    public var targetCyclesAcross: CGFloat = WaveShapeProperty.cyclesAcross.defaultValue
//    public var displayedCyclesAcross: CGFloat = .zero
//  }
//}

//extension WaveProperties.Engine {
// public mutating func updateProperty(
//    _ property: WaveEngineProperty,
//    dt: CGFloat,
//    timeConstant: CGFloat
//  ) {
//    let currentValue = self[keyPath: property.displayedKeyPath]
//    let targetValue = self[keyPath: property.targetKeyPath]
//
//    self[keyPath: property.displayedKeyPath] = currentValue.smoothed(
//      towards: targetValue,
//      dt: dt,
//      timeConstant: timeConstant
//    )
//  }
//}
//
//extension WaveProperties.Shape {
//  public mutating func updateProperty(
//    _ property: WaveShapeProperty,
//    dt: CGFloat,
//    timeConstant: CGFloat
//  ) {
//    let currentValue = self[keyPath: property.displayedKeyPath]
//    let targetValue = self[keyPath: property.targetKeyPath]
//
//    self[keyPath: property.displayedKeyPath] = currentValue.smoothed(
//      towards: targetValue,
//      dt: dt,
//      timeConstant: timeConstant
//    )
//  }
//}
