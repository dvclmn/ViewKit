//
//  BasePrimitivesTests.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Testing
import CoreGraphics
@testable import BasePrimitives

@Suite("Division – Saturating vs Failable semantics")
struct DivisionSemanticsTests {
  @Test("Saturating: non-zero divisor divides and clamps negatives to zero")
  func saturatingDivision() {
    let size = CGSize(width: 10, height: 20)
    let result = size.divideBoth(by: 2)
    #expect(result.width == 5)
    #expect(result.height == 10)
    
    let negative = CGSize(width: -4, height: 8).divideBoth(by: 2)
    #expect(negative.width == 0) // clamped
    #expect(negative.height == 4)
  }
  
  @Test("Saturating: zero divisor returns zeros")
  func saturatingZeroDivisor() {
    let size = CGSize(width: 10, height: 20)
    let result = size.divideBoth(by: 0)
    #expect(result.width == 0)
    #expect(result.height == 0)
  }
  
  @Test("Failable: exact division succeeds for finite non-zero")
  func failableExactSuccess() {
    let size = CGSize(width: 10, height: 20)
    let result = size.dividingBothExactly(by: 2)
    let unwrapped = #require(result)
    #expect(unwrapped.width == 5)
    #expect(unwrapped.height == 10)
  }
  
  @Test("Failable: exact division fails for zero or non-finite")
  func failableExactFailure() {
    let size = CGSize(width: 10, height: 20)
    #expect(size.dividingBothExactly(by: 0) == nil)
    #expect(size.dividingBothExactly(by: .infinity) == nil)
    #expect(size.dividingBothExactly(by: .nan) == nil)
  }
  
  @Test("Provider-based saturating: uses selected axis factor, zero becomes zeros")
  func providerBasedSaturating() {
    let size = CGSize(width: 10, height: 20)
    let provider = CGSize(width: 2, height: 0) // vertical is zero
    let resH = size.divideBoth(by: provider, using: .horizontal, mapping: .identity)
    #expect(resH.width == 5)
    #expect(resH.height == 10)
    
    let resV = size.divideBoth(by: provider, using: .vertical, mapping: .identity)
    #expect(resV.width == 0)
    #expect(resV.height == 0)
  }
  
  @Test("Provider-based failable: exact variant returns nil for zero/non-finite")
  func providerBasedFailable() {
    let size = CGSize(width: 10, height: 20)
    let provider = CGSize(width: 2, height: 0)
    
    let ok = #require(size.dividingBothExactly(by: provider, using: .horizontal, mapping: .identity))
    #expect(ok.width == 5)
    #expect(ok.height == 10)
    
    let fail = size.dividingBothExactly(by: provider, using: .vertical, mapping: .identity)
    #expect(fail == nil)
  }
}

@Suite("Mapping – Identity vs Transposed")
struct MappingTests {
  @Test("Unary transform both axes with explicit mapping")
  func unaryBothMapping() {
    let size = CGSize(width: 2, height: 4)
    let doubled = size.adjustBoth(mapping: .identity) { $0 * 2 }
    #expect(doubled.width == 4)
    #expect(doubled.height == 8)
    
    // Should produce same numeric result even under transposed,
    // though the underlying read/write fields are flipped by mapping.
    let doubledT = size.adjustBoth(mapping: .transposed) { $0 * 2 }
    #expect(doubledT.width == 4)
    #expect(doubledT.height == 8)
  }
  
  @Test("Component-wise combination with other under mapping")
  func componentWiseWithOther() {
    let a = CGSize(width: 10, height: 5)
    let b = CGSize(width: 8, height: 12)
    let c = a.adjustBoth(with: b, mapping: .identity) { max($0, $1) }
    #expect(c.width == 10)
    #expect(c.height == 12)
  }
}
