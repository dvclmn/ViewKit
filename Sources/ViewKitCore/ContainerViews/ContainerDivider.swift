//
//  ContainerDivider.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import CoreTools
import ViewTools
import SwiftUI

public struct ContainerDivider: View {
  @Environment(\.widthOverride) private var widthOverride
  @Environment(\.heightOverride) private var heightOverride

  public var body: some View {

    Divider()
      .frame(width: widthOverride, height: heightOverride)
      .opacity(0.7)
    //      .fixedSize(horizontal: false, vertical: isVerticalFixed)

  }
}
extension ContainerDivider {
  /// This is an attempt to prevent the `Divider()` from
  /// pushing/expanding its parent view outwards, which is very annoying.
  ///
  /// If an explicit height is provided, then we don't need to make it fixed
  private var isVerticalFixed: Bool { heightOverride == nil }
}
