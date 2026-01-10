//
//  CopyTextButton.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/9/2025.
//

import BasePrimitives
import SwiftUI


public struct CopyTextButton: View {
  @Environment(\.popup) private var popup

  let title: String
  let contentToCopy: String?

  public init(
    _ title: String,
    contentToCopy: String? = nil,
  ) {
    self.title = title
    self.contentToCopy = contentToCopy
  }
  public var body: some View {

    Button {
      copyStringToClipboard(contentToCopy ?? title)
      popup?.showPopup("Copied to clipboard", icon: Icons.copyAlt.icon)

    } label: {
      Label(title, systemImage: Icons.copy.icon)
        .symbolVariant(.fill)
      //      Text(title)
      //        .font(.caption)
      //        .foregroundStyle(.secondary)
    }
    .buttonStyle(.base)

  }
}
