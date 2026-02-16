//
//  IconView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/9/2025.
//

import CoreTools
import SwiftUI

public struct IconView: View {
  @Environment(\.labelDisplay) private var labelDisplay

  let icon: IconLiteral

  public init(_ icon: IconLiteral) {
    self.icon = icon
  }

  public var body: some View {
    Group {
      switch icon {
        case .emoji(let emojiString): Text(emojiString)
        case .symbol(let symbolString): Image(systemName: symbolString)
        case .customSymbol(_): Text("Custom Symbol not implemented")
      //          Image(
      //            ImageResource(
      //              name: customSymbol.reference,
      //              bundle: Bundle.module
      //            )
      //          )
      }
    }
  }
}
