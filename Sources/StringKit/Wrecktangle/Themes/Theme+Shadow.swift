//
//  Theme+Shadow.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

/// Thoughts for a parametric shadow system
///
/// - Any characters provided for any one parameter, will be cycled randomly
/// - There will be different classes of characters, that represent different
/// qualities, such as angle, orientation, opacity, etc
///
/// E.g. this `⣓` feels more anchored to the `bottomLeading` corner.
/// This `⡻` would be considered `topTrailing`.
///
/// - Define 3, maybe 4 levels of strength (opacity). Any more would cause
/// the shadow to take up too much room.
/// - Light source will (of course) determine the angle
/// - Hardness/spread — The gradient of the transition from fully black to full white
/// - Rounding? Fall-off? Not sure if this would be a result of hardness or not. But would
/// describe the sharpness/roundness of the corners of the shape formed overall by the shadow
///
/// ```
///    ░░░░░░░░░░░       ░░░░░░░░░░░░░░░░░
///  ░░▒▒▒▒▒▒▒▒▒▒▒░░     ░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░
/// ░░▒▒┌───────┐▒▒░░    ░░▒▒┌───────┐▒▒░░
/// ░░▒▒│       │▒▒░░    ░░▒▒│       │▒▒░░
/// ░░▒▒│       │▒▒░░    ░░▒▒│       │▒▒░░
/// ░░▒▒└───────┘▒▒░░    ░░▒▒└───────┘▒▒░░
///  ░░▒▒▒▒▒▒▒▒▒▒▒░░     ░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░
///    ░░░░░░░░░░░       ░░░░░░░░░░░░░░░░░
///
/// ```

extension Box.Theme {

  public struct Shadow: Sendable {
    var type: ShadowType
    var lightSource: Box.LightSource
    var strength: ShadowStrength

    public init(
      type: ShadowType = .simple,
      lightSource: Box.LightSource = .topTrailing,
      strength: ShadowStrength = .light
    ) {
      self.type = type
      self.lightSource = lightSource
      self.strength = strength
    }
  }
}

extension Box.Theme.Shadow {

  /// What do we need to know to create a shadow for a side?
  ///
  /// 1. Dimensions — only 1x character high for text lines, but need
  /// height to make sure I match structural lines
  /// 2. Whether it repeats horizontally
  /// 3. Alignment based on light source
  ///

  /// Referring to horizontal space only
  ///
  public var reservedSpace: Int {
    switch type {
      case .simple:
        1
      case .none:
        0
    }
  }

  public enum ShadowType: Sendable {
    case simple
    case none
  }  // END shadow type

  public enum ShadowStrength: Sendable {
    case light
    case medium
    case dark

    public var character: Character {
      switch self {
        case .light:
          "░"
        case .medium:
          "▒"
        case .dark:
          "▓"
      }
    }
  }

}

extension Box {

  public enum LightSource: Sendable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing

    public func hasShadow(_ location: Box.PartType.VerticalLocation) -> Bool {
      switch location {
        case .leading:
          self == .topLeading || self == .bottomLeading
        case .trailing:
          self == .topTrailing || self == .bottomTrailing
        case .interior:
          false
      }
    }

  }  // END light source
}
