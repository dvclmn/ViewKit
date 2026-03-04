//
//  Env+Label.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension EnvironmentValues {

  /// Labels
  @Entry public var labelColour: AnyShapeStyle? = nil
  @Entry public var labelWeight: Font.Weight? = nil
  @Entry public var labelFontStyle: Font.TextStyle? = nil
  @Entry public var labelFontSize: CGFloat? = nil
  @Entry public var labelTextCase: Text.Case? = nil

  /// This is useful because SwiftUI exposes control over display of
  /// icon and label elements in the form of the `LabelStyle` protocol.
  /// So when using custom label styles, setting e.g. `labelStyle(iconOnly)`
  /// will override the custom style. This works around that.
  @Entry public var labelDisplay: LabelDisplay? = nil

  /// Icons
  @Entry public var iconColour: AnyShapeStyle? = nil
  @Entry public var iconWeight: Font.Weight? = nil
  @Entry public var iconFontSize: CGFloat? = nil

  /// Already a native value for this: `labelIconToTitleSpacing`
  //  @Entry public var labelIconSpacing: CGFloat? = nil

}
