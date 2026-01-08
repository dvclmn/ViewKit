//
//  GridPadding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import SharedHelpers
import SwiftUI

// MARK: - Normal Padding
public struct GridPaddingModifier: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  let edges: Edge.Set
  let count: Int

  public func body(content: Content) -> some View {
    content
      .padding(
        edges,
        gridPaddingLength(
          edges: edges,
          count: count,
          unitSize: unitSize
        )
      )
  }
}

// MARK: - Safe Area Padding
@available(macOS 14.0, *)
public struct GridSafeAreaPaddingModifier: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  let edges: Edge.Set
  let count: Int

  public func body(content: Content) -> some View {
    content
      .safeAreaPadding(
        edges,
        gridPaddingLength(
          edges: edges,
          count: count,
          unitSize: unitSize
        )
      )
  }
}

extension View {

  public func gridPadding(
    _ edges: Edge.Set = .all,
    _ count: Int
  ) -> some View {
    self.modifier(GridPaddingModifier(edges: edges, count: count))
  }

  @available(macOS 14.0, *)
  public func gridSafeAreaPadding(
    _ edges: Edge.Set = .all,
    _ count: Int
  ) -> some View {
    self.modifier(GridSafeAreaPaddingModifier(edges: edges, count: count))
  }
}

private func gridPaddingLength(
  edges: Edge.Set = .all,
  count: Int,
  unitSize: CGSize?
) -> CGFloat? {
  
  fatalError("Not sure how to properly define Edges and Axis here")
  
  /// Maybe there's a way to not require the middle part of having to weirdly convert to
  /// an Axis. Maybe can just convert count to screenLength and be done with it?
  
//  guard let axis = edges.to else { return nil }
//  guard let axis = edges.toAxis(using: .widthIsHorizontal) else { return nil }
//  return count.toScreenLength(along: axis, using: unitSize)
}
