//
//  Shape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

extension Shape where Self == RoundedRectangle {
  public static var rounded: Self { .rounded() }
  public static func rounded(_ radius: CGFloat = 4) -> Self {
    Self(cornerRadius: radius)
  }
}
