//
//  Compat+SafePadding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/12/2025.
//

import SwiftUI

extension View {
  @ViewBuilder
  public func safePaddingCompatible(
    _ edges: Edge.Set = .all,
    _ length: CGFloat? = nil
  ) -> some View {
    if #available(macOS 14.0, iOS 17.0, *) {
      self.safeAreaPadding(edges, length)
    } else {
      self.padding(edges, length)
    }
  }
}
