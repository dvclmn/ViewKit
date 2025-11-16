//
//  SizeTestView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import CoreTools
import SwiftUI

public struct SizeTestView: View {

  let size: CGFloat
  public var body: some View {

    ScrollView(.horizontal) {
      VStack(alignment: .leading) {
        TextWithSize(12)
        TextWithSize(28)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      //      .border(Color.green.opacity(0.3))
    }

    //      .environment(\.unitSize, CGSize(width: 1, height: 2))

    //      .padding(100)
    //    .frame(
    //      minWidth: 700,
    //      maxWidth: .infinity,
    //      maxHeight: .infinity,
    //      alignment: .leading
    //    )

  }
}

extension SizeTestView {
  @ViewBuilder
  private func TextWithSize(_ size: CGFloat) -> some View {
    Text("I'm a sentence with 73 characters. I want to see when we reach the thing.")
      .gridGuide(opacity: 0.3)
      .setCharacterUnitSize(mode: .debounce(0.2))
      .gridFont(.sfMono, size: size)
  }
}

#if DEBUG
#Preview {
  SizeTestView(size: 22)
}
#endif
