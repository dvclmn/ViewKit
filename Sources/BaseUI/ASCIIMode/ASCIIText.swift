//
//  ASCIIText.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

public struct ASCIIText: View {
  // @Environment(AppHandler.self) private var store
  @Environment(\.isASCIIMode) private var isASCIIMode
  @Environment(\.asciiModeFontSize) private var asciiModeFontSize
  @Environment(\.gridFont) private var gridFont

  let key: LocalizedStringKey

  public init(
    _ key: LocalizedStringKey
  ) {
    self.key = key
  }

  public var body: some View {

    //    if let gridFont {
    Text(key)
      .gridFont(for: .asciiMode)
    //        .gridFont(gridFont, size: asciiModeFontSize ?? 22)
    //    } else {
    //      Text(key)
    //    }

  }
}

extension ASCIIText {

}
#if DEBUG
//#Preview {
#Preview(traits: .size(.normal)) {
  ASCIIText("I'm an ASCIIText View")
    .frame(width: 300, height: 600)
    .environment(\.isASCIIMode, true)
  //    .gridFont(.ibm, size: 40)
}
#endif
