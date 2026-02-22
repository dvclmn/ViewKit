//
//  ResizableExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import CoreTools
import SwiftUI

struct ResizableExampleView: View {

  @State private var overlayHeight: CGFloat = 200

  var body: some View {

    HStack(spacing: 0) {

      VStack {

        ScrollView {
          Text(String(repeating: SampleContent.Strings.paragraphs[2], count: 2))
            .opacity(0.4)
        }
        .background(.blue.quaternary)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .topLeading
        )

        .overlay(alignment: .bottom) {
          OverlayView()
            //            .border(Color.green.opacity(0.3))
            .padding()
        }
      }
      .modifier(
        ResizableModifier(
          height: $overlayHeight,
          axis: .vertical
        )
      )

      Rectangle()
        .fill(.green.tertiary)
    }

  }
}

extension ResizableExampleView {
  @ViewBuilder
  private func OverlayView() -> some View {
    Rectangle()
      .fill(.thinMaterial)
      .fill(.brown.opacity(0.3))

      .frame(
        maxWidth: .infinity,
        minHeight: 100,
//                maxHeight: overlayHeight,
        alignment: .bottom
      )
      .frame(height: overlayHeight)
      .clipShape(.rect(cornerRadius: Styles.sizeRegular))

  }
}
#if DEBUG
#Preview {
  ResizableExampleView()
    .frame(width: 500, height: 600)
}
#endif
