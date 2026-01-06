//
//  EdgeInsets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/8/2025.
//

import SwiftUI

extension EdgeInsets {

  /// This permits the omission of any one of the four
  /// parameters, which the default init doesn't allow for.
  public init(
    top: CGFloat = 0,
    left: CGFloat = 0,
    bottom: CGFloat = 0,
    right: CGFloat = 0
  ) {
    self.init(
      top: top,
      leading: left,
      bottom: bottom,
      trailing: right
    )
  }

  public static var zero: EdgeInsets { EdgeInsets() }

  //  public init(horizontal: CGFloat = 0, vertical:  sCGFloat = 0) {
  //    self.init(
  //      top: vertical,
  //      leading: horizontal,
  //      bottom: vertical,
  //      trailing: horizontal
  //    )
  //  }

}
