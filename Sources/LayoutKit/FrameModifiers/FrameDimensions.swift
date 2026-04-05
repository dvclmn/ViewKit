//
//  FrameDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/7/2025.
//

import BasePrimitives
import SwiftUI
import BaseTools

public struct FrameGridDimensions {
  public var width: Int?
  public var height: Int?
  public var alignment: Alignment

  public init(width: Int? = nil, height: Int? = nil, alignment: Alignment = .center) {
    self.width = width
    self.height = height
    self.alignment = alignment
  }

  public init(from gridDimensions: GridDimensions?, alignment: Alignment = .center) {
    self.init(
      width: gridDimensions?.width,
      height: gridDimensions?.height,
      alignment: alignment
    )
  }
}

/// This is essentially equivalent to `CGSize`, but with optional
/// values, to pair nicely with SwiftUI's `.frame()` modifier.
/// I think `.frame()` lets you fall back to the layout system's
/// proposed frame size (for that dimension) when you pass
/// in an optional value.
public struct FrameDimensions: Sendable {
  public var width: CGFloat?
  public var height: CGFloat?
  public var alignment: Alignment

  public static let `default` = FrameDimensions()

  public init(
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    alignment: Alignment = .center
  ) {
    self.width = width
    self.height = height
    self.alignment = alignment
  }

  public init(
    fromSize size: CGSize?,
    alignment: Alignment = .center
  ) {
    self.width = size?.width
    self.height = size?.height
    self.alignment = alignment
  }

  public init(
    fromLength length: CGFloat?,
    axis: Axis.Set = .horizontal,
    alignment: Alignment = .center
  ) {
    guard !axis.isEmpty else {
      self.width = nil
      self.height = nil
      self.alignment = alignment
      return
    }

    if axis == .horizontal {
      self.width = length
      self.height = nil

    } else if axis == .vertical {
      self.width = nil
      self.height = length

    } else {
      self.width = length
      self.height = length
    }

    self.alignment = alignment
  }
}

extension FrameDimensions: ExpressibleByNilLiteral {
  public init(nilLiteral: ()) {
    self.init(width: nil, height: nil)
  }
}
extension FrameGridDimensions: ExpressibleByNilLiteral {
  public init(nilLiteral: ()) {
    self.init(width: nil, height: nil)
  }
}

extension FrameDimensions {
  public var toCGSize: CGSize? {
    guard let width, let height else { return nil }
    return CGSize(width: width, height: height)
  }
}

extension FrameGridDimensions {
  public func toFrameDimensions(
    with unitSize: CGSize?
  ) -> FrameDimensions {
    guard let unitSize, let width, let height else { return nil }
    let w = width.toScreenLength(using: unitSize.width)
    let h = height.toScreenLength(using: unitSize.height)
    return FrameDimensions(width: w, height: h)
    //    guard let width, let height else { return nil }
    //    return CGSize(width: width, height: height)
  }
}



//extension FrameDimensions: CustomStringConvertible {
//  public var description: String {
//    return
//      "FrameDimensions[W: \(width?.displayString ?? "nil"), H: \(height?.displayString ?? "nil"), Alignment: \(alignment.displayName.abbreviated)]"
//  }
//}
