//
//  BasePrimitivesTests.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Testing
import CoreGraphics
@testable import BasePrimitives

@Suite("AdjustableByAxis – Single-axis adjustments")
struct SingleAxisAdjustmentsTests {
  @Test("Set horizontal/vertical under identity mapping")
  func setUnderIdentity() {
    let size = CGSize(width: 10, height: 20)
    let wider = size.adjust(.horizontal, newValue: 30, mapping: .identity)
    #expect(wider.width == 30)
    #expect(wider.height == 20)
    
    let taller = size.adjust(.vertical, newValue: 40, mapping: .identity)
    #expect(taller.width == 10)
    #expect(taller.height == 40)
  }
  
  @Test("Set horizontal/vertical under transposed mapping")
  func setUnderTransposed() {
    let size = CGSize(width: 10, height: 20)
    // Under transposed, horizontal maps to secondary (height)
    let wider = size.adjust(.horizontal, newValue: 30, mapping: .transposed)
    #expect(wider.width == 10)
    #expect(wider.height == 30)
    
    // Under transposed, vertical maps to primary (width)
    let taller = size.adjust(.vertical, newValue: 40, mapping: .transposed)
    #expect(taller.width == 40)
    #expect(taller.height == 20)
  }
  
  @Test("Transform along axis")
  func transformAlongAxis() {
    let point = CGPoint(x: 5, y: 8)
    let shifted = point.adjust(.horizontal, mapping: .identity) { $0 + 10 }
    #expect(shifted.x == 15)
    #expect(shifted.y == 8)
  }
}

@Suite("AdjustableByAxis – Dual-axis numeric adjustments")
struct DualAxisAdjustmentsTests {
  @Test("Unary transform both axes with mapping")
  func unaryBothWithMapping() {
    let size = CGSize(width: 2, height: 4)
    let doubled = size.adjustBoth(mapping: .identity) { $0 * 2 }
    #expect(doubled.width == 4)
    #expect(doubled.height == 8)
    
    // Transposed should still produce same numeric result, but via flipped storage mapping
    let doubledT = size.adjustBoth(mapping: .transposed) { $0 * 2 }
    #expect(doubledT.width == 4)
    #expect(doubledT.height == 8)
  }
  
  @Test("Binary transform that coordinates axes")
  func binaryBoth() {
    let size = CGSize(width: 2, height: 4)
    let normalized = size.adjustBoth(mapping: .identity) { h, v in
      let m = max(h, v)
      return (h / m, v / m)
    }
    #expect(abs(normalized.width - 0.5) < 0.0001)
    #expect(abs(normalized.height - 1.0) < 0.0001)
  }
  
  @Test("Component-wise combination with other")
  func componentWiseWithOther() {
    let a = CGSize(width: 10, height: 5)
    let b = CGSize(width: 8, height: 12)
    let c = a.adjustBoth(with: b, mapping: .identity) { max($0, $1) }
    #expect(c.width == 10)
    #expect(c.height == 12)
  }
  
  @Test("Uniform scaling using one axis from provider")
  func uniformScalingFromProviderAxis() {
    let base = CGSize(width: 10, height: 20)
    let factors = CGSize(width: 2, height: 3)
    // Scale both by horizontal factor (2)
    let scaledH = base.multiplyBoth(by: factors, using: .horizontal, mapping: .identity)
    #expect(scaledH.width == 20)
    #expect(scaledH.height == 40)
    
    // Scale both by vertical factor (3)
    let scaledV = base.multiplyBoth(by: factors, using: .vertical, mapping: .identity)
    #expect(scaledV.width == 30)
    #expect(scaledV.height == 60)
  }
  
  @Test("Division with explicit divisor")
  func divisionWithDivisor() {
    let size = CGSize(width: 10, height: 20)
    let result = size.divideBoth(by: 2)
    #expect(result.width == 5)
    #expect(result.height == 10)
  }
  
  @Test("Division using one axis from provider")
  func divisionUsingProviderAxis() {
    let size = CGSize(width: 10, height: 20)
    let divisorProvider = CGSize(width: 2, height: 5)
    
    let resultH = size.divideBoth(by: divisorProvider, using: .horizontal, mapping: .identity)
    #expect(resultH.width == 5)
    #expect(resultH.height == 10)
    
    let resultV = size.divideBoth(by: divisorProvider, using: .vertical, mapping: .identity)
    #expect(resultV.width == 2)
    #expect(resultV.height == 4)
  }
}

@Suite("AxisMapping helpers")
struct AxisMappingHelpersTests {
  @Test("select primary/secondary under different mappings")
  func selectUnderMapping() {
    #expect(AxisMapping.identity.select(primary: 1, secondary: 2, for: .horizontal) == 1)
    #expect(AxisMapping.identity.select(primary: 1, secondary: 2, for: .vertical) == 2)
    #expect(AxisMapping.transposed.select(primary: 1, secondary: 2, for: .horizontal) == 2)
    #expect(AxisMapping.transposed.select(primary: 1, secondary: 2, for: .vertical) == 1)
  }
  
  @Test("pair reorders correctly")
  func pairReorders() {
    let pI = AxisMapping.identity.pair(h: "H", v: "V")
    #expect(pI.primary == "H")
    #expect(pI.secondary == "V")
    
    let pT = AxisMapping.transposed.pair(h: "H", v: "V")
    #expect(pT.primary == "V")
    #expect(pT.secondary == "H")
  }
}
