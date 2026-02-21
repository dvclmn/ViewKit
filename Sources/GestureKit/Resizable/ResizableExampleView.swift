//
//  ResizableExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import CoreTools
import SwiftUI

struct ResizableExampleView: View {
  @State private var overlayHeight: Double = 200

  var body: some View {

    HStack(spacing: 0) {

      VStack {

        ScrollView {
          Text(String(repeating: SampleContent.Strings.paragraphs[2], count: 2))
        }
        .background(.blue.quaternary)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .topLeading
        )

        .overlay(alignment: .bottom) {
          Rectangle()
            .fill(.thinMaterial)
            .fill(.brown.opacity(0.3))
            .modifier(ResizableModifier())
            .frame(
              minHeight: 100,
              maxHeight: overlayHeight,
              alignment: .bottom
            )

        }
      }

      Rectangle()
        .fill(.green.tertiary)
    }

  }
}

extension ResizableExampleView {

}
#if DEBUG
#Preview {
  ResizableExampleView()
    .frame(width: 500, height: 600)
}
#endif
