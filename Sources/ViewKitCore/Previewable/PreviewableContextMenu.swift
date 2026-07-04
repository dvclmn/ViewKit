//
//  PreviewableContextMenu.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/10/2025.
//

import CoreTools
import ViewTools
import SwiftUI

public struct ContextMenuPreviewModifier<MenuContent: View>: ViewModifier {
  @Environment(\.sizeOverride) private var sizeOverride
  @Environment(\.layoutAlignment) private var layoutAlignment

  let isPreviewing: Bool
  @ViewBuilder let menuContent: MenuContent
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: layoutAlignment ?? .center) {
        if isPreviewing, isPreview {

          VStack(alignment: .leading, spacing: Styles.sizeSmall.bump) {
            menuContent
          }
          .frame(
            width: sizeOverride?.width ?? 180,
            height: sizeOverride?.height,
            alignment: .topLeading
          )
          .padding()
          .glassEffectCompatible(in: .rect(cornerRadius: Styles.sizeRegular))
          .buttonStyle(.plain)
          //      .font(.callout)
          .foregroundStyle(.primary.opacity(0.96))
          //            .quickBackground()

        }
      }
  }
}

extension View {
  public func contextMenuPreview<Content>(
    isPreviewing: Bool,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View where Content: View {
    self.modifier(
      ContextMenuPreviewModifier<Content>(
        isPreviewing: isPreviewing,
        menuContent: content
      )
    )
  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//
//  Text("Hello")
//    .previewableContextMenu(isPreviewing: true) {
//      Button {
//      } label: {
//        Label("Open in New Window", systemImage: Icons.newWindow.icon)
//      }
//
//      Divider()
//
//      Button {
//      } label: {
//        Label("Mark Favourite", systemImage: Icons.heart.icon)
//      }
//
//      Button {
//      } label: {
//        Label("Add to Wishlist", systemImage: Icons.gift.icon)
//      }
//
//      //      .padding(100)
//    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//}
//#endif
