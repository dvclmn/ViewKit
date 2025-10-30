//
//  Repeater.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import LayoutKit
import StringShared
import SwiftUI

public struct Repeater<Content: View>: View {
  @Environment(\.isDebugMode) private var isDebugMode

  let count: Int
  let axis: Axis?
  let spacing: CGFloat?
  let content: Content

  public init(
    _ count: Int,
    axis: Axis? = nil,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.count = count
    self.axis = axis
    self.spacing = spacing
    self.content = content()
  }

  public var body: some View {

    DynamicStack(axis: axis, spacing: spacing) {
      ForEach(0..<self.count, id: \.self) { count in
        content
          .overlay {
            if isDebugMode {
              Text("Count: \(count)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: true, vertical: false)
            }
          }
      }
    }
    //    .background(Color.red.quaternary)
    //    .frame(minWidth: 100, minHeight: 100)
    //    .debugTextOverlay("Repeating \(count) times", alignment: .topLeading)
    //    .border(Color.green.opacity(0.3))
  }
}
