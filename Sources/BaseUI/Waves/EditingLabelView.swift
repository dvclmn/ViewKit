//
//  EditingLabelView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//

import BasePrimitives
import SwiftUI

public struct EditingLabel: View {
  @Environment(\.isEmphasised) private var isEmphasised

  public var body: some View {

    if isEmphasised {
      Text("Editing")
        .font(.caption.weight(.medium))
        .foregroundStyle(Color.accentColor)
        .brightness(0.26)
        .padding(.horizontal, Styles.sizeSmall.bump)
        .padding(.vertical, Styles.sizeMicro.bump)
        .background {
          Capsule().fill(Color.black.tertiary)
//          Capsule().fill(Color.accentColor.quinary)
        }
    }

  }
}
