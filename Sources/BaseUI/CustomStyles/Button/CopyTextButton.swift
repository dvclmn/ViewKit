//
//  CopyTextButton.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/9/2025.
//

import CoreTools
import SwiftUI
import ViewTools

// TODO: Make a version with popup enabled?
//public struct CopyTextButton: View {
//  @Environment(\.popup) private var popup
//
//  let title: String
//  let contentToCopy: String
//
//  public init(
//    _ title: String = "Copy",
//    contentToCopy: String,
//  ) {
//    self.title = title
//    self.contentToCopy = contentToCopy
//  }
//  public var body: some View {
//
//    Button {
//      copyStringToClipboard(contentToCopy)
//      popup?.showPopup(.make("Copied to clipboard", icon: .preset(.copyAlt)))
//
//    } label: {
//      Label(title, systemImage: Icons.copyAlt.icon)
//        .symbolVariant(.fill)
//      //      Text(title)
//      //        .font(.caption)
//      //        .foregroundStyle(.secondary)
//    }
//    .buttonStyle(.base)
//
//  }
//}
//
