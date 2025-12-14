//
//  ToolTipExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/9/2025.
//

import SwiftUI

@available(macOS 14.0, *)
public struct ToolTipExampleView: View {

  let exampleAlignment: [Color: Alignment] = [
    Color.red: .topLeading,
    Color.brown: .top,
    Color.green: .topTrailing,
    Color.cyan: .trailing,
    Color.mint: .bottomTrailing,
    Color.indigo: .bottom,
    Color.purple: .bottomLeading,
    Color.yellow: .leading,
    Color.orange: .center,
  ]

  private let isOnIcon: Bool = false

  public var body: some View {

    VStack(spacing: 60) {
      ForEach(
        exampleAlignment.sorted(byKeyPath: \.value.displayName.abbreviated),
        id: \.value.displayName.abbreviated
      ) { colour, alignment in

        Text("Got a ToolTip. Alignment: \(alignment.displayName.full)")
          .fixedSize(horizontal: true, vertical: false)
          .foregroundStyle(colour.opacityMid)
          .tooltip(
            "\(alignment.displayName.standard)",
            //            offset: alignment == .bottom ? CGSize(30, 60) : .zero,
            alignment: alignment,
            isShowingForDebug: true,
            color: colour.opacityLow
              //                        color: .blue
          )

      }
    }

  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  ToolTipExampleView()
    .padding(140)
}
#endif
