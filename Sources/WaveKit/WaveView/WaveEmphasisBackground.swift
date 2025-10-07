//
//  WaveEmphasisBackground.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//

import BaseComponents
import BaseHelpers
import SwiftUI

public struct WaveEmphasisModifier: ViewModifier {
  @Environment(\.isEmphasised) private var isEmphasised
  let padding: CGFloat
  private let rounding: CGFloat = Styles.sizeSmall.bump
  public func body(content: Content) -> some View {
    content
      .mask {
        RoundedRectangle(cornerRadius: rounding)
          .fill()
          .padding(isEmphasised ? padding : .zero)
      }
      .scrollMask(
        axis: .horizontal,
        fallOffLength: 50,
        //        scrollLocation: .mid
      )
      .background {
        if isEmphasised {
          RoundedRectangle(cornerRadius: rounding)
            .fill(Color.accentColor.tertiary)
            //            .stroke(Color.accentColor.secondary, lineWidth: 2)
            .padding(padding)
        }
      }
  }
}
