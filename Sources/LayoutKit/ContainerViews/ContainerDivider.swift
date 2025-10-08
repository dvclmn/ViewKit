//
//  ContainerDivider.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import SwiftUI
import SharedHelpers

public struct ContainerDivider: View {
  @Environment(\.explicitWidth) private var explicitWidth
  @Environment(\.explicitHeight) private var explicitHeight
  
  public var body: some View {
    
    Divider()
      .frame(width: explicitWidth, height: explicitHeight)
      .opacity(0.7)
      .fixedSize(horizontal: false, vertical: isVerticalFixed)
    
  }
}
extension ContainerDivider {
  /// This is an attempt to prevent the `Divider()` from
  /// pushing/expanding its parent view outwards, which is very annoying.
  ///
  /// If an explicit height is provided, then we don't need to make it fixed
  private var isVerticalFixed: Bool { explicitHeight == nil }
}
