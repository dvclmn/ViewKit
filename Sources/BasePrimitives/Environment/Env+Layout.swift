//
//  Env+Layout.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension EnvironmentValues {

  /// View layout
  /// See `LayoutKit` for `layoutMode`
  @Entry public var layoutAxis: Axis? = nil
  @Entry public var layoutAlignment: Alignment? = nil
  @Entry public var textAlignment: TextAlignment? = nil

  /// Use this for spacing specifically (`VStack`/`HStack` etc)
  /// For padding, prefer `layoutPadding`.
  @Entry public var layoutSpacing: CGFloat? = nil

  /// If addressing spacing, prefer `layoutSpacing`.
  @Entry public var layoutPadding: CGFloat? = nil

  /// Useful for targeting the inside of nested scroll views
  /// Note: using name `safePadding` to disambiguate from `safeAreaPadding`
  @Entry public var safePadding: EdgeInsets? = nil

  /// For things like weighted padding, giving more
  /// breathing room to the X axis etc. Increase to add width
  @Entry public var horizontalBias: CGFloat? = nil

  /// Adds bias to the height of a View within it's parent.
  /// Increase to shift content upward
  @Entry public var opticalCentreBias: CGFloat? = nil

  /// This (perhaps unneccesarily) pairs with `ContainerValue`
  /// of the same name, in BaseHelpers' Compatible collection.
  @Entry public var isShowingSectionHeader: Bool = true
  @Entry public var isBackgroundHidden: Bool = false

  /// Character columns here refers to a fixed number of characters
  /// (usually monospaced for consistency) in a horizontal line,
  /// usually for the purpose of achieving a predictable layout
  /// with working with varying character counts.
  /// See ``TextColumns`` for an example.
  @Entry public var maxCharacterColumns: Int = 5

}
