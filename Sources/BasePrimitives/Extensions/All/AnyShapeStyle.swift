//
//  AnyShapeStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI

extension AnyShapeStyle {
  public init?(_ colour: Color?) {
    guard let colour else { return nil }
    self.init(colour)
  }
  public static var clear: Self { Self(Color.clear) }

  public var opacityBarelyThere: Self { Self(opacity(OpacityPreset.opacityBarelyThere.rawValue)) }
  public var opacityFaint: Self {
    Self(opacity(OpacityPreset.opacityFaint.rawValue))
  }
  public var opacityLow: Self {
    Self(opacity(OpacityPreset.opacityLow.rawValue))
  }
  public var opacityMid: Self {
    Self(opacity(OpacityPreset.opacityMid.rawValue))
  }
  public var opacityMedium: Self {
    Self(opacity(OpacityPreset.opacityMedium.rawValue))
  }
  public var opacityHigh: Self {
    Self(opacity(OpacityPreset.opacityHigh.rawValue))
  }
  public var opacityNearOpaque: Self {
    Self(opacity(OpacityPreset.opacityNearOpaque.rawValue))
  }
}

extension TintShapeStyle {
  public var opacityBarelyThere: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityBarelyThere.rawValue))
  }
  public var opacityFaint: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityFaint.rawValue))
  }
  public var opacityLow: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityLow.rawValue))
  }
  public var opacityMid: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityMid.rawValue))
  }
  public var opacityMedium: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityMedium.rawValue))
  }
  public var opacityHigh: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityHigh.rawValue))
  }
  public var opacityNearOpaque: AnyShapeStyle {
    AnyShapeStyle(opacity(OpacityPreset.opacityNearOpaque.rawValue))
  }
}
