//
//  ASCIIText.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import CoreTools
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

    if let gridFont {
      Text(key)
        .gridFont(gridFont, size: asciiModeFontSize ?? 22)
    }

  }
}

//extension ExampleView {
//
//}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  // @Previewable @State var store = AppHandler()
//  ExampleView()
//  // .environment(store)
//}
//#endif
