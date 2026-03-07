//
//  PreviewablePopover.swift
//  BaseComponents
//
//  Created by Dave Coleman on 6/9/2025.
//

import BasePrimitives
import SwiftUI

public struct PreviewablePopoverModifier<PopoverContent: View>: ViewModifier {
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.sizeOverride) private var sizeOverride

  @Binding var isPresented: Bool
  let attachmentAnchor: PopoverAttachmentAnchor
  let arrowEdge: Edge?
  let isPreviewing: Bool

  @ViewBuilder let popoverContent: PopoverContent

  public func body(content: Content) -> some View {
    content
      .popover(
        isPresented: $isPresented,
        attachmentAnchor: attachmentAnchor,
        arrowEdge: arrowEdge
      ) {
        PopoverView()
      }
      .overlay(alignment: layoutAlignment ?? .topTrailing) {
        if isPreviewing, isPreview {
          PopoverView()
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(
              width: sizeOverride?.width,
              //              width: sizeOverride?.width ?? 400,
              height: sizeOverride?.height
                //              height: sizeOverride?.height ?? 600
            )
          #warning("Will need to sort something for this, now that this is in UIPrimitives")
//            .quickBackground()
        }
      }
  }
}

extension PreviewablePopoverModifier {
  @ViewBuilder
  func PopoverView() -> some View {
    popoverContent
    //      .padding(.top, Styles.toolbarHeightPrimary)
  }
}

extension View {
  public func previewablePopover<Content>(
    _ isPresented: Binding<Bool>,
    attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
    arrowEdge: Edge? = nil,
    isPreviewing: Bool,
    @ViewBuilder popoverContent: @escaping () -> Content
  ) -> some View where Content: View {
    self.modifier(
      PreviewablePopoverModifier<Content>(
        isPresented: isPresented,
        attachmentAnchor: attachmentAnchor,
        arrowEdge: arrowEdge,
        isPreviewing: isPreviewing,
        popoverContent: popoverContent
      ))
  }
}
