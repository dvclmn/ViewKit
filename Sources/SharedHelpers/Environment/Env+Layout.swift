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
  /// breathing room to the X axis etc
  @Entry public var horizontalBias: CGFloat? = nil

}
