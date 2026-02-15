//
//  PopupTitleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import SwiftUI

struct PopupTitleView: View {
  @Environment(\.isCompactMode) private var isCompactMode

  let message: PopupMessage
  let hasCloseButton: Bool

  var body: some View {

    MaybeLabel(message.label)
      .font(.system(size: isCompactMode ? 11 : 14))
      .fontWeight(.medium)

      /// To leave room for the dismiss button
      .padding(.trailing, hasCloseButton ? 20 : 0)

  }
}
