//
//  ToolTipExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/9/2025.
//

import SwiftUI

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

    VStack(spacing: 20) {
      ForEach(
        exampleAlignment.sorted(byKeyPath: \.value.displayName.abbreviated),
        id: \.value.displayName.abbreviated
      ) { colour, alignment in
        VStack {
          ToolTip(colour, alignment)
            .font(.title2)

          ToolTip(colour, alignment)
            .font(.caption)
        }

      }
    }

  }
}

extension ToolTipExampleView {
  @ViewBuilder
  private func ToolTip(_ colour: Color, _ alignment: Alignment) -> some View {

    Text("Got a ToolTip. Alignment: \(alignment.displayName.full)")
      .fixedSize(horizontal: true, vertical: false)
      .foregroundStyle(colour.secondary)
      .padding(8)
      .tooltip(
        "\(alignment.displayName.standard)",
        //            offset: alignment == .bottom ? CGSize(30, 60) : .zero,
        alignment: alignment,
        isShowingForDebug: true,
        color: colour.opacityLow
          //                        color: .blue
      )

      .background(colour.opacity(0.05))
  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.narrow)) {
  ToolTipExampleView()
    .padding(20)
}
#endif
